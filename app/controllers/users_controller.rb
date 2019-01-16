class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @users.ransack params[:users]
    @users = @q.result.paginate page: params[:page],
      per_page: Settings.users.paginate.per_page
    respond_to do |format|
      format.html
      format.js
    end
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
