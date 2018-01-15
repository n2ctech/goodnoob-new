class BlueTomatoCrawler
URL_TO_SUBCATEGORY_MAPPINGS = {
  'https://www.blue-tomato.com/en-ES/products/categories/Snowboard-00000000--Snowboard+Bindings-0000000A/' => 'Snow Bindings',
  'https://www.blue-tomato.com/en-ES/products/categories/Snowboard-00000000--Snowboard+Boots-0000000E/' => 'Snowboots',
  'https://www.blue-tomato.com/en-ES/products/categories/Snowboard-00000000--Snowboards-00000001--Freestyle+Snowboards-00000002/' => 'Snowboards',
  'https://www.blue-tomato.com/en-ES/products/categories/Snowboard-00000000--Snowboards-00000001--Freeride+Snowboards-00000003/' => 'Snowboards',
  'https://www.blue-tomato.com/en-ES/products/categories/Freeski-0000000V--Ski+Bindings-00000010/' => 'Ski Bindings',
  'https://www.blue-tomato.com/en-ES/products/categories/Freeski-0000000V--Ski+Boots-00000011/' => 'Ski boots',
  'https://www.blue-tomato.com/en-ES/products/categories/Freeski-0000000V--Freeski-0000000W--Freestyle+Skis-0000000X/' => 'Skis',
  'https://www.blue-tomato.com/en-ES/products/categories/Freeski-0000000V--Freeski-0000000W--Freeride+Skis-0000000Y/' => 'Skis'
}

links = {
  'Snow Bindings' => [], # 16
  'Snowboots' => [], # 6
  'Snowboards' => [], # 5
  'Ski Bindings' => [], # 17
  'Ski boots' => [], # 9
  'Skis' => [], # 8
}

options = {
  "User-Agent" => "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36",
  "Cookie" => "userlocale=ES-EUR-en"
}

def parse_data(doc, sub_category)
  urls = []

  doc.css('li.productcell').each do |el|
    a = el.at('a.name')

    name = a['data-productname']
    year = nil

    if name.end_with?('2015', '2016', '2017', '2018', '2019')
      year = name.rpartition(' ').last.to_i
      name = name.rpartition(' ').first
    end

    puts "Year #{year}"

    next if sub_category.products.exists?(name: name, year: year)

    urls << ('https://www.blue-tomato.com' + a['href'])
  end

  urls
end

URL_TO_SUBCATEGORY_MAPPINGS.each do |category_url, sub_category_name|
  sub_category = SubCategory.find_by(name_en: sub_category_name)

  doc = Nokogiri::HTML open(category_url, options).read

  urls = parse_data(doc, sub_category)

  links[sub_category_name].concat urls

  while next_page = doc.at('.pagination li.next a')
    doc = Nokogiri::HTML open('https://www.blue-tomato.com' + next_page['href'], options).read
    urls = parse_data(doc, sub_category)
    links[sub_category_name].concat urls
  end
end

not_found_urls = []

links.each do |sub_category_name, urls|

  sub_category = SubCategory.find_by(name_en: sub_category_name)

  urls.each do |url|
    begin
    next if Product.exists?(blue_tomato_product_code: url)

    doc = Nokogiri::HTML open(url, options).read

    name = doc.at('.c-details-box__variant-name').text.strip
    year = nil

    if name.end_with?('2015', '2016', '2017', '2018', '2019')
      year = name.rpartition(' ').last.to_i
      name = name.rpartition(' ').first
    end

    next if sub_category.products.exists?(name: name, year: year)

    product = Product.new(
      sub_category: sub_category,
      name: name,
      year: year,
      blue_tomato_product_code: url
    )

    company_name = doc.at('img.c-details-box__logo').try(:[], :title)
    company_name ||= doc.at('h1.c-details-box__name span').text.strip
    company = Company.where(name: company_name).first_or_create!
    product.company = company

    doc.css('a.js-thumb').each do |image|
      if image['data-ref7col'].present?
        product.pictures.build image_remote_url: 'https:' + image['data-ref7col']
      end
    end

    es_doc = Nokogiri::HTML open(url.sub('en-ES', 'es-ES'), options).read
    fr_doc = Nokogiri::HTML open(url.sub('en-ES', 'fr-ES'), options).read

    product.description_en = doc.at('.c-product-description__text').to_html
    product.description_es = es_doc.at('.c-product-description__text').to_html
    product.description_fr = fr_doc.at('.c-product-description__text').to_html
    # description_en = full_description_en.at('h2').to_html
    # en_description_doc = Nokogiri::HTML.fragment full_description_en.at('p').to_html.gsub('<br><br><strong>', '</p><p><strong>')
    # en_doc.css('p').each_with_index do |p, index|
    #   description_en << p.to_html if index == 0

    # end

    eur_price = doc.at('meta[property="og:price:amount"]')[:content].to_f
    product.prices.build amount: eur_price, currency: Currency.find_by!(code: 'EUR')

    product.region_product_urls.build url: url, region: Region.find_by!(name: 'Europe')

    _for = doc.css('.c-breadcrumb__link')[2].text.strip
    for_filter_option = sub_category.filters.find_by!(name_en: 'For...').filter_options.find_by(name_en: _for)

    if for_filter_option
      product.filter_options << for_filter_option
    end

    doc.css('li.c-attributes-features__item').each do |el|
      filter_name = el.at('span.c-attributes-features__name').text.strip.chomp(':')
      filter_option_name = el.xpath('text()').last.text.strip
      # ["Flex", "Riding Level", "Type", "Stiffness", "Riding Style", "Shape",
      # "Camber", "For...", "Tech", "Flex Rating"]
      case filter_name
      when ''
      end
    end

    product.save!
  rescue OpenURI::HTTPError => e
    if e.message =~ /404 Not Found/
      not_found_urls << url
      next
    end
  end
  end
end
end
