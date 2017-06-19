$(document).ready ->
  $alert_danger   = $('.alert-danger')
  $alert_success  = $('.alert-success')

  $alert_danger.remove()
  $alert_success.remove()

  danger_text   = $alert_danger.find('#flash_alert').text()
  success_text  = $alert_success.find('#flash_alert').text()

  if success_text.length
    toastr.success(success_text)

  if danger_text.length
    toastr.error(danger_text)
