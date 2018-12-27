class SessionsController < ApplicationController
  include SessionsHelper

  # callbacks
  before_action :load_user, only: :create

  def new; end

  def create
    if @user.authenticate(params[:session][:password])
      sign_in @user
      flash[:success] = t ".flash.sign_in_successful"
      redirect_to root_path
    else
      flash.now[:danger] = t ".flash.sign_in_failed"
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private
  def load_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user

    flash[:danger] = t ".flash.user_not_found"
    redirect_to sign_in_path
  end
end