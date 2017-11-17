#= require active_admin/base

#= require redactor
#= require redactor/inlinestyle
#= require redactor/source
#= require redactor/codemirror
#= require redactor/alignment
#= require redactor/table
#= require redactor/fullscreen
#= require redactor/fontsize
#= require redactor/fontcolor
#= require redactor/fontfamily
#= require redactor/video
#= require redactor/imagemanager
#= require redactor/filemanager
#= require redactor/properties
#= require redactor/definedlinks
#= require redactor/limiter
#= require redactor/textdirection
#= require redactor/counter
#= require redactor/imagelink
#= require codemirror
#= require codemirror/modes/xml

$ ->
  if $('#product_sub_category_id').length == 0
    return
  $('#product_sub_category_id').change ->
    if typeof gon != 'undefined' && typeof gon.product_id != 'undefined'
      $.get '/ajax_get_filter_options/' + $(@).val() + '?product_id=' + gon.product_id,
        (data) -> $('#product_filter_options_input').html data
    else
      $.get '/ajax_get_filter_options/' + $(@).val(),
        (data) -> $('#product_filter_options_input').html data


$(document).ready ->
  if $('#product_sub_category_id').length == 0
    return

  product_id = gon.product_id

  if $('#product_sub_category_id').val() > 0
    if product_id.length == 0
      $.get '/ajax_get_filter_options/' + $('#product_sub_category_id').val(),
        (data) -> $('#product_filter_options_input').html data
    else
      $.get '/ajax_get_filter_options/' + $('#product_sub_category_id').val() + '?product_id=' + product_id,
        (data) -> $('#product_filter_options_input').html data


$ ->
  $('#guide_description_en, #guide_description_es, #guide_description_fr,
    #info_about_description_en, #info_about_description_es, #info_about_description_fr,
    #info_question_description_en, #info_question_description_es, #info_question_description_fr,
    #info_privacy_description, #info_term_description,
    #product_description_en, #product_description_es, #product_description_fr,
    #company_description_en, #company_description_es, #company_description_fr,
    #distributor_information_en, #distributor_information_es, #distributor_information_fr').redactor
    plugins: [
      'inlinestyle'
      'codemirror'
      'alignment'
      'table'
      'fullscreen'
      'fontsize'
      'fontcolor'
      'fontfamily'
      'video'
      'textexpander'
      'textdirection'
      'imagelink'
    ]
    imageUpload: '/guide_images'
    imageResizable: true
    imagePosition: true
    codemirror:
      lineNumbers: true
      mode: 'xml'
      indentUnit: 4
      theme: 'default'
      lineWrapping: true
