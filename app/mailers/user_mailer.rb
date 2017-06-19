class UserMailer < ApplicationMailer
  def welcome user
    @user = user
    @logo = 'http://' << default_url_options[:host] << '/logo.png'
    case user.locale
    when 'en'
      subject = 'Welcome to GoodNoob!'
    when 'fr'
      subject = 'Bienvenue sur GoodNoob!'
    when 'es'
      subject = 'Bienvenido a GoodNoob!'
    else
      subject = 'Welcome to GoodNoob!'
    end

    mail to: user.email, subject: subject
  end

  def first_photo_upload user
    @user = user
    @logo = 'http://' << default_url_options[:host] << '/logo.png'
    subject = 'Thank you for uploading first picture'
    mail to: user.email, subject: subject
  end

  def first_video_upload user
    @user = user
    @logo = 'http://' << default_url_options[:host] << '/logo.png'
    subject = 'Thank you for uploading first video'
    mail to: user.email, subject: subject
  end
end
