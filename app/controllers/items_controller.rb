class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      render json: user.items, status: :ok
    else
      render json: Item.all, include: :user, status: :ok
    end
  end

  def show
    render json: Item.find(params[:id]), status: :ok
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create!(item_params)
    render json: item, status: :created
  end

  private
  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found
    render json: {error: "Record not found"}, status: :not_found
  end
end
