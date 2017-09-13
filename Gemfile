source 'https://rubygems.org'
ruby '2.3.4'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'masonry-rails'
gem 'slim-rails'
gem 'rails', '4.2.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'bootstrap-sass'
gem 'devise'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'high_voltage'
gem 'activeadmin', github: 'activeadmin'
gem 'geocoder'
gem 'paperclip', '~> 4.3'
gem 'paperclip-optimizer'
gem 'image_optim'
gem 'image_optim_pack'
gem 'aws-sdk', '< 2'
gem 'kaminari'
gem 'pg'
gem 'gon'
gem 'active_model_serializers'
gem 'autoprefixer-rails'
gem 'magnific-popup-rails', '~> 1.1.0'
gem 'rollbar'
gem 'toastr-rails'
gem 'readmorejs-rails'
gem 'bootstrap-wysihtml5-rails'
gem 'active_admin_editor', github: 'ejholmes/active_admin_editor'
gem 'video_info'
gem 'traco'
gem 'i18n-tasks', '~> 0.9.12'
gem 'slim'
gem 'font-awesome-rails'
gem "jquery-slick-rails"
gem 'flag-icons-rails'
gem 'redactor2', github: 'nguyenducgiang/redactor2', branch: '2.8.1'
gem 'codemirror-rails'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog-aws'
gem 'puma'

group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'pry-rails', '0.3.6'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'better_errors'
  gem 'hub', require: false
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring-commands-rspec'
  gem 'annotate'
  gem 'thin'
  gem 'letter_opener'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end

group :production do
  gem 'rails_12factor'
  gem 'heroku-deflater'
end
