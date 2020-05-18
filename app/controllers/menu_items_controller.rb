class MenuItemsController < ApplicationController
  before_action :ensure_user_logged_in

  def index
  end

  def create
    menu_item = MenuItem.new(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      img_url: params[:img_url],
      menu_id: session[:current_menu_id],
    )
    if menu_item.save
      redirect_to menu_path(session[:current_menu_id])
    else
      flash[:error] = menu_item.errors.full_messages.join(", ")
      redirect_to menu_path(session[:current_menu_id])
    end
  end

  def destroy
    id = params[:id]
    menu = MenuItem.all.find(id)
    menu.destroy
    redirect_to menu_path(session[:current_menu_id])
  end

  def home
    render "home"
  end

  def edit
    @menu_item = MenuItem.find(params[:id])
  end

  def update
    @menu_item = MenuItem.find(params[:id])
    @menu_item.update(name: params[:menu_item][:name], price: params[:menu_item][:price], description: params[:menu_item][:description])
    redirect_to menus_path
  end
end
