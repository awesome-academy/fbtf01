class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.paginate page: params[:page],
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
end
