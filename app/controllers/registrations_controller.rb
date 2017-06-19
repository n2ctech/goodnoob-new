class RegistrationsController < Devise::RegistrationsController
  def edit
    current_user.build_address unless current_user.address
  end

  private

  def account_update_params
    params.require(:user).permit(:email,:password, :password_confirmation, :current_password,
      :name, :last_name, :bio, :language_id, :currency_id, address_attributes: [:id, :country, :city])
  end

  def sign_up_params
    params.require(:user).permit(:email,:password, :password_confirmation, :name,
      :locale)
  end

  protected

  def update_resource(resource, params)
    if [params[:password], params[:password_confirmation], params[:current_password]].any?(&:present?)
      resource.update_with_password(params)
    else
      resource.update_without_password(params.except(:current_password))
    end
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end
end
