class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    ensure_owner_logged_in
  end

  def create
    role = "customer"
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
        redirect_to sessions_home_path
      end
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
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

  def change_role
    user = User.find(params[:id])
    user.role = params[:role]
    user.save
    redirect_to users_path
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(name: params[:user][:name], email: params[:user][:email], phone_number: params[:user][:phone_number], password: params[:user][:password])
      flash[:success] = "Profile has been updated"
    else
      flash[:error] = "Could not update profile"
    end
    redirect_to sessions_home_path
  end
end
