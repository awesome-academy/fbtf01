class UsersController < ApplicationController
  # callbacks
  before_action :signed_in_user, :load_user, :correct_user,
    except: [:index, :new, :create]

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

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".flash.update_profile_successful"
      redirect_to edit_user_path
    else
      flash.now[:danger] = t ".flash.update_profile_failed"
      render :edit
    end
  end

  def edit_password; end

  def update_password
    if @user.update_attributes user_params
      flash[:success] = t ".flash.update_password_successful"
      redirect_to edit_password_path
    else
      flash.now[:danger] = t ".flash.update_password_failed"
      render :edit_password
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :address, :phone
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "users.flash.user_not_found"
    redirect_to root_path
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = t "users.flash.incorrect_user"
    redirect_to root_path
  end
end
