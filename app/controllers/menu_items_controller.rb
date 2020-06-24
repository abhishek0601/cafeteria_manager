class MenuItemsController < ApplicationController
  before_action :ensure_user_logged_in
  before_action :ensure_owner_logged_in

  def create
    menu_item = MenuItem.new(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      category: params[:category],
      img_url: params[:img_url],
      menu_id: session[:current_menu_id],
    )
    if menu_item.save
      flash[:success] = "Menu Item has been added successfully"
      redirect_to menu_path(session[:current_menu_id])
    else
      flash[:error] = menu_item.errors.full_messages.join(", ")
      redirect_to add_item_path(session[:current_menu_id])
    end
  end

  def destroy
    id = params[:id]
    menu_item = MenuItem.all.find(id)
    menu_item.destroy
    redirect_to menu_path(session[:current_menu_id])
  end

  def edit
    @menu_item = MenuItem.find(params[:id])
  end

  def update
    @menu_item = MenuItem.find(params[:id])
    @menu_item.update(name: params[:menu_item][:name], price: params[:menu_item][:price], img_url: params[:menu_item][:img_url], category: params[:menu_item][:category], description: params[:menu_item][:description])
    flash[:success] = "Menu Item updated successfully"
    redirect_to menu_path(session[:current_menu_id])
  end
end
