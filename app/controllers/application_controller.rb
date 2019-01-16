class ApplicationController < ActionController::Base
  # callbacks
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def admin_user
    return if current_user.admin?

    flash[:danger] = t "application.flash.user_not_admin"
    redirect_to root_path
  end

  def configure_permitted_parameters
    added_attrs = [:name, :address, :phone]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
