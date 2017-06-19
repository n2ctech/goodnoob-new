$(document).ready ->
  $('body').on 'click', '#welcome_login_button', ->
    $('#welcome_login_form, #welcome_login_image').addClass('hidden')
    $('#welcome_register_form, #welcome_register_image').removeClass('hidden')
  $('body').on 'click', '#welcome_register_button', ->
    $('#welcome_login_form, #welcome_login_image').removeClass('hidden')
    $('#welcome_register_form, #welcome_register_image').addClass('hidden')
  $('body').on 'click', '#btnLogin', ->
    $('#SignInModal').modal({show: true})
  $('body').on 'click', '#btnRegister', ->
    $('#SignUpModal').modal({show: true})
  $('body').on 'click', '#learn', ->
    $('#learn-image-text, #compare-image, #share-image, #share-big, #compare-big, #welcome_register_image').addClass('hidden')
    $('#learn-image, #compare-image-text, #share-image-text, #learn-big').removeClass('hidden')
  $('body').on 'click', '#compare', ->
    $('#compare-image-text, #learn-image, #share-image, #share-big, #learn-big, #welcome_register_image').addClass('hidden')
    $('#compare-image, #share-image-text, #learn-image-text, #compare-big').removeClass('hidden')
  $('body').on 'click', '#share', ->
    $('#share-image-text, #compare-image, #learn-image, #learn-big, #compare-big, #welcome_register_image').addClass('hidden')
    $('#share-image, #learn-image-text, #compare-image-text, #share-big').removeClass('hidden')
