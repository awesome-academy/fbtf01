class PasswordResetsController < ApplicationController
  before_action :load_user, :check_expiration, only: [:edit, :update]

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".flash.password_reset_email_sent"
      redirect_to root_path
    else
      flash.now[:danger] = t ".flash.email_not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t(".flash.password_empty")
      render :edit
    elsif @user.update_attributes(user_params)
      sign_in @user
      @user.update_attribute :reset_digest, nil
      flash[:success] = t ".flash.password_reset_success"
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  # Load user from database using email
  def load_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t ".flash.user_not_found"
    redirect_to root_path
  end

  # Checks expiration of reset token.
  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t ".flash.password_reset_expired"
    redirect_to new_password_reset_path
  end
end
