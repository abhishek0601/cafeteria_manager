class MenusController < ApplicationController
  before_action :ensure_user_logged_in
  before_action :ensure_owner_logged_in, :only => [:create, :destroy]
  before_action :ensure_staff_logged_in, :only => [:update]

  def index
    render "index"
  end

  def create
    new_menu = Menu.new(
      name: params[:name],
      menu_url: params[:menu_url],
    )
    if new_menu.save
      flash[:success] = "Menu added successfully"
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
    menu = Menu.find(id)
    menu.destroy
    redirect_to menus_path
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update_menu
    @menu = Menu.find(params[:id])
    @menu.update(name: params[:menu][:name], menu_url: params[:menu][:menu_url])
    flash[:success] = "Menu updated successfully"
    redirect_to menus_path
  end

  def update
    id = params[:id]
    active = params[:active]
    @menu = Menu.find(id)
    @menu.update(active: active)
    redirect_to menus_path
  end
end
