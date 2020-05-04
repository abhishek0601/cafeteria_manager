class MenuItemsController < ApplicationController
  before_action :ensure_user_logged_in

  def index
  end

  def create
    menu_item = MenuItem.new(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      menu_id: session[:current_menu_id],
    )
    if menu_item.save
      redirect_to menu_path
    else
      flash[:error] = menu_item.errors.full_messages.join(", ")
      redirect_to menu_path
    end
  end

  def destroy
    id = params[:id]
    menu = MenuItem.all.find(id)
    menu.destroy
    redirect_to menus_path
  end

  def home
    render "home"
  end
end
