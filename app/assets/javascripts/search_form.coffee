$(document).on 'turbolinks:load', ->
  new SearchForm $(elem) for elem in $('.search-form--inline')

class SearchForm
  constructor: (@el)->
    @input = @el.find('.search-field')
    @suggestions = @el.find('.suggestions')
    @products = @el.find('.s-products')
    @categories = @el.find('.s-categories')
    @input.on 'keyup', @onKeyUp
    @input.on 'blur', @onBlur

  onKeyUp: =>
    query = @input.val()
    if !query or query.length < 3
      @suggestions.slideUp()
    else
      clearTimeout(@searchDelay);
      @searchDelay = setTimeout(@searchProduct, 200)

  onBlur: =>
    slideUp = => @suggestions.slideUp()
    setTimeout(slideUp, 200)

  searchProduct: =>
    query = @input.val()
    $.ajax '/search/suggestions' ,
      type: "GET",
      dataType: "JSON",
      data:
        search: query
      success: (suggestions) =>
        @render(query, suggestions)
        @suggestions.slideDown()

  render: (query, suggestions) =>
    @renderCategories(query, suggestions)
    @renderProducts(query, suggestions.products)

  renderProducts: (query, products) =>
    html = ''
    for product in products
      html += @productTemplate(query, product)
    @products.html(html)

  renderCompanies: (query, companies) =>
    html = @socialFeedTemplate(query)
    for product in products
      html += @categoryTemplate(query, product)
    @categories.html(html)

  renderCategories: (query, suggestions) =>
    result = [@socialFeedTemplate(query)]
    for product in suggestions.products
      result.push @categoryTemplate(query, product)
    for company in suggestions.companies
      result.push @companyTemplate(query, company)
    @categories.html(result.join(''))

  productTemplate: (query, product) ->
    "<a href='/products/#{product.id}' class='s-suggestion'>#{@productTitle(product, query)}</a>"

  categoryTemplate: (query, product) ->
    search_params = $.param { search: product.name }
    "<a class='s-suggestion' href='/sub_categories/#{product.sub_category.id}?#{search_params}'>" +
    "  #{@productTitle(product, query)} in " +
    "  <span class='s-highlight-primary'>#{product.sub_category.name}</span>" +
    "</a>"

  companyTemplate: (query, company) ->
    result = ''
    for sub_category in company.sub_categories
      result += @subCategoryTemplate(query, company, sub_category)
    result

  subCategoryTemplate: (query, company, sub_category) ->
    search_params = $.param { companies: [company.id] }
    "<a class='s-suggestion' href='/sub_categories/#{sub_category.id}?#{search_params}'>" +
    "  #{@highlight(company.name, query)} in " +
    "  <span class='s-highlight-primary'>#{sub_category.name} Compare</span>" +
    "</a>"

  socialFeedTemplate: (query) ->
    search_params = $.param { search: query }
    "<a class='s-suggestion' href='/search?#{search_params}'>" +
    "  <span class='s-query'>#{query}</span> in " +
    "  <span class='s-highlight-primary'>Social Feed</span>" +
    "</a>"


  highlight: (text, word) ->
    rgxp = new RegExp(word, 'gi')
    repl = '<span class="s-query">$&</span>'
    text.replace(rgxp, repl)

  productTitle: (product, query) ->
    value = product.name
    value += " (#{product.year})" if product.year
    value = @highlight(value, query) if query
    value
