class ApplicationMailer < ActionMailer::Base
  default from: 'GoodNoob <no-reply@goodnoob.com>'
  layout 'mailer'
  append_view_path Rails.root.join('app', 'views', 'mailers')
end
