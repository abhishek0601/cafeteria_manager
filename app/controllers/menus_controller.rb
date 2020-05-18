class MenusController < ApplicationController
  before_action :ensure_user_logged_in

  def index
    render "index"
  end

  def create
    new_menu = Menu.new(
      name: params[:name],
    )
    if new_menu.save
      redirect_to menus_path
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
      redirect_to menus_path
    end
  end

  def show
    id = params[:id]
    session[:current_menu_id] = id
    menu = Menu.find(id)
    render "menu_item", locals: { menu: menu }
  end

  def destroy
    id = params[:id]
    menu_item = MenuItem.all.find(id)
    menu_item.destroy
    redirect_to menus_path
  end

  def update
    id = params[:id]
    active = params[:active]
    menu = Menu.find(id)
    menu.active = active
    menu.save!
    redirect_to menus_path
  end
end
