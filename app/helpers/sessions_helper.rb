module SessionsHelper
  # Sign in the given user.
  def sign_in user
    session[:user_id] = user.id
  end

  # Returns the signed-in user (if exists).
  def current_user
    @current_user ||= User.find_by id: session[:user_id] if session[:user_id]
  end

  # Returns true if the user is signed in.
  def signed_in?
    !current_user.nil?
  end

  # Sign out the current user.
  def sign_out
    session.delete :user_id
    @current_user = nil
  end
end
