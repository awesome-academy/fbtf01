class ApplicationController < ActionController::Base
  include SessionsHelper

  # callbacks
  before_action :set_locale

  # Confirms a logged-in user.
  def signed_in_user
    return if signed_in?

    flash[:danger] = t "application.flash.not_signed_in"
    redirect_to root_path
  end

  private
  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
