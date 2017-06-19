class ProductSearchService

  attr_accessor :search_string, :sub_categories, :companies, :start_row_index,
                :take_count, :products, :has_more, :media

  def initialize( params )
    self.search_string = params[:search]
    self.sub_categories = params[:sub_categories]
    self.companies = params[:companies]
  end

  def search
    self.products = Product.base_search(search_string, sub_categories, companies)
    self.media = products.media.sort_by{|e| e.created_at}.reverse
    self
  end

  def suggestions
    { products:
        Product.where('lower(products.name) LIKE lower(?)', "%#{search_string}%")
               .includes(:sub_category)
               .first(5)
               .as_json(only: [:id, :name, :year],
                        include: { sub_category: { only: [:id, :name ] } }),
      companies:
        Company.search(search_string)
               .includes(:sub_categories)
               .first(5)
               .as_json(only: [:id, :name],
                        include: { sub_categories: { only: [:id, :name ] } })
    }
  end

end
