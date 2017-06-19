class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :resource_name, :resource, :devise_mapping

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_filter :store_current_location, unless: :devise_controller?

  before_action :set_current_currency
  before_action :set_locale
  before_action :set_admin_locale

  include UserLocation

  private

    def store_current_location
      store_location_for(:user, request.url)
    end

    def set_current_currency
      Currency.current_currency = current_user&.currency || Currency.find_by(code: 'EUR')
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :locale])
      devise_parameter_sanitizer.permit(:account_update, keys:[:name, :locale])
    end

    def resource_name
      :user
    end

    def resource
      @resource ||= User.new
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end

    def set_locale
      if session[:locale].blank?
        case request.location&.country
        when "France"
          session[:locale] = :fr
        when "Spain"
          session[:locale] = :es
        else
          session[:locale] = :en
        end
      end
      if current_user&.locale.in? %w[en es fr]
        session[:locale] = current_user.locale
      end
      I18n.locale = session[:locale]
    end

    def set_admin_locale
      if request.url =~ /\/admin/
        I18n.locale = I18n.default_locale
      end
    end

end
