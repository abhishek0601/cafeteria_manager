class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in

  def ensure_user_logged_in
    unless current_user
      flash[:error] = "Login to view this page"
      redirect_to "/"
    end
  end

  def ensure_owner_logged_in
    unless current_user.role == "owner"
      flash[:error] = "Only Owner can view this page"
      redirect_to "/home"
    end
  end

  def ensure_staff_logged_in
    unless current_user.role != "customer"
      flash[:error] = "You are not allowed to access this page"
      redirect_to "/home"
    end
  end

  def current_user
    return @current_user if @current_user

    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    else
      nil
    end
  end
end
