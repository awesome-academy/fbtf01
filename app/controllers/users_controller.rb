class UsersController < ApplicationController
  # callbacks
  before_action :authenticate_user!
  before_action :load_user, except: :index
  before_action :admin_user

  def index
    @users = User.newest.paginate page: params[:page],
      per_page: Settings.users.paginate.per_page
  end

  def show; end

  def destroy
    if @user.destroy
      flash[:success] = t ".flash.delete_user_successful"
    else
      flash[:danger] = t ".flash.delete_user_failed"
    end
    redirect_to users_path
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "users.flash.user_not_found"
    redirect_to root_path
  end
end
