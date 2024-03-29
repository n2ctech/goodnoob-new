# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#js-product-media .thumb-wrapper').hide()
  $('#js-show-less').hide()

  size_li = $('#js-product-media .thumb-wrapper').size()
  per_page = 12
  x = per_page

  if size_li <= x
    $('#js-load-more').hide()

  $('#js-product-media .thumb-wrapper:lt(' + x + ')').show()

  $('#js-load-more').click ->
    x = if x + per_page <= size_li then x + per_page else size_li
    $('#js-product-media .thumb-wrapper:lt(' + x + ')').show()

    $('#js-show-less').show()
    if x == size_li
      $('#js-load-more').hide()
    return

  $('#js-show-less').click ->
    if x == size_li
      y = x % per_page
      y = per_page if y == 0
    else
      y = per_page

    x = if x - per_page < 0 then per_page else x - y
    $('#js-product-media .thumb-wrapper').not(':lt(' + x + ')').hide()

    $('#js-load-more').show()
    if x <= per_page
      $('#js-show-less').hide()
    return

  $('.video').click ->
    $('#photo_form').addClass('hidden')
    $('#video_form').removeClass('hidden')
  $('.photo').click ->
    $('#photo_form').removeClass('hidden')
    $('#video_form').addClass('hidden')
  $('#masonry-container').masonry
    itemSelector: '.box'
    columnWidth: (containerWidth) ->
      if containerWidth > 1000
        containerWidth / 5
      else if containerWidth > 800
        containerWidth / 4
      else if containerWidth > 600
        containerWidth / 3
      else if containerWidth > 400
        containerWidth / 2
      else
        containerWidth
