class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in, :except => [:index]

  def index
    render "index"
  end

  def create
    role = "customer"
    if session[:current_user_id]
      role = "clerk"
    end
    user = User.new(
      name: params[:name].capitalize,
      email: params[:email],
      role: role,
      phone_number: params[:phone_number],
      address: params[:address],
      password: params[:password],
    )
    if user.save
      if session[:current_user_id]
        redirect_to users_path
      else
        session[:current_user_id] = user.id
        flash[:success] = "Signed-up Successfully!!"
        redirect_to new_menu_items_home_path
      end
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_sessions_path
    end
  end

  def new
    render "users/new"
  end

  def destroy
    id = params[:id]
    user = User.all.find(id)
    user.destroy
    redirect_to users_path
  end
end
