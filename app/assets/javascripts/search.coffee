$(document).on 'turbolinks:load', ->
  $('.check__form').on 'change', ->
    $('#filter_form').submit()


  ###
  $('.search-results-container').infinitescroll
    loading:
      img: '../assets/spinner.svg'
    navSelector: '.showmore-thumbs-row' # selector for the paged navigation (it will be hidden)
    nextSelector: '.showmore-thumbs-row .show-more-text' # selector for the NEXT link (to page 2)
    itemSelector: '.search-results-container .thumb-wrapper' # selector for all items you'll retrieve
    path: (pageNumber) ->
      return $('.showmore-thumbs-row .show-more-text').attr("href")

  ###

  $(window).on 'scroll', ->
    showmore = $('.showmore-thumbs-row')
    if showmore.length == 0
      return
    if showmore.offset().top < $(window).scrollTop() + $(window).height()
      if !window.ajax and $('.search-results-have-more').data('hasmore')
        window.ajax = true
        $('.check__form').attr('disabled', true)
        showmore.find('.loading-spinner').show()
        showmore.find('.plus-button-wrapper').hide()
        showmore.find('.showmore-text-wrapper').hide()
        $.ajax
          url: showmore.find('.show-more-text').attr('href')
          dataType: 'script'


  $(document).on 'click', '.remove-from-favorites', (event) ->
    event.preventDefault()
    $this = $(@)
    url = $this.attr 'href'
    $.ajax
      method: "GET",
      url: url,
      success: ->
        $this.closest('.filter-wrapper').slideUp()

  $(document).on 'click', '.remove-search', (event) ->
    event.preventDefault()
    $this = $(@)
    url = $this.attr 'href'
    $.ajax
      method: "GET",
      url: url,
      success: ->
        $this.closest('.filter-wrapper').slideUp()

  $(document).on 'click', '.applied-sub-filter', (event) ->
    event.preventDefault()
    $this = $(@)
    $(@).fadeOut()
    id = $this.data('id')
    switch $this.data( 'type')
      when 'filter' then $("#checkbox_#{id}").attr('checked', null).change()
      when 'company' then $("#checkbox_com_#{id}").attr('checked', null).change()
      when 'year_from' then $('#year_from').val($("#year_from option:first").val()).change()
      when 'year_to' then $('#year_to').val($("#year_from option:first").val()).change()
      when 'price_from' then reset_price_from()
      when 'price_to' then reset_price_to()

  $(document).on 'click', '.sort-by-panel a', (e) ->
    e.preventDefault()
    $this = $(@)
    field = $this.data 'field'
    desc = $this.data('desc') != true
    $this.data('desc', desc)
    if desc
      $this.find('.glyphicon').removeClass('glyphicon-triangle-top').addClass('glyphicon-triangle-bottom')
    else
      $this.find('.glyphicon').removeClass('glyphicon-triangle-bottom').addClass('glyphicon-triangle-top')
    $('.sort-by-panel a').removeClass('active')
    $this.addClass('active')
    $('#search_field').val field
    $('#search_direction').val desc
    $('#filter_form').submit()

  $(document).on 'click', '.js-apply-sort', (e) ->
    e.preventDefault()
    return if window.ajax
    $this = $(@)
    field = $this.data 'field'
    desc = $this.data('desc') == true
    $('#search_field').val field
    $('#search_direction').val desc
    $('#filter_form').submit()

reset_price_from = ->
  $slider = $('#slider')
  prices = $slider.slider('option', 'values')
  $slider.slider('values', 0, $slider.slider('option', 'min'))
  $slider.slider('option', 'slide').call()
  $('#filter_form').submit()

reset_price_to = ->
  $slider = $('#slider')
  prices = $slider.slider('option', 'values')
  $slider.slider('values', 1, $slider.slider('option', 'max'))
  $slider.slider('option', 'slide').call()
  $('#filter_form').submit()
