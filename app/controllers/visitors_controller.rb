class VisitorsController < ApplicationController

  # PATCH /select_locale
  def select_locale
    if params[:locale].in? %w[en fr es]
      session[:locale] = params[:locale]
      current_user.update(locale: params[:locale]) if current_user
    end
    redirect_to :back
  end

  # PATCH /select_country
  def select_country
    country = Country.find_by(country_code: params[:country]&.upcase)
    if country
      session[:country] = country.country_code
      session[:country_id] = country.id
      current_user.update(country: country) if current_user
    end
    redirect_to :back
  end

  # PATCH /select_currency
  def select_currency
    currency = Currency.find_by(code: params[:currency]&.upcase)
    if currency
      session[:currency] = currency.code
      current_user.update(currency: currency) if current_user
    end
    redirect_to :back
  end

end
