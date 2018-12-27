class UsersController < ApplicationController
  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in @user
      flash[:success] = t ".flash.create_successful"
      redirect_to root_path
    else
      flash.now[:danger] = t ".flash.create_failed"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :address, :phone
  end
end
