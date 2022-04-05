class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    # Items GET /users/:user_id/items returns an array of all items belonging to a user
    if params[:user_id]
      user = find_user
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = find_item
    render json: item
  end
  # Items POST /users/:user_id/items creates a new item belonging to a user
  def create
    user = find_user
    item = user.items.create(item_params)
    render json: item, status: :created
  end

  private

  def find_user
    User.find(params[:user_id])
  end

  def find_item
    Item.find(params[:id])
  end

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response(exception)
    render json: { errors: "#{exception.model} not found" }, status: :not_found
  end
end
