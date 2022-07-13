class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  def create
    new_item = Item.create!(item_params)
    render json: ItemSerializer.new(new_item), status: :created
  end

  def destroy
    render json: Item.find(params[:id]).destroy
  end

  def update
    # binding.pry
    item = Item.update(params[:id], item_params)
    render json: ItemSerializer.new(item)
  end

  private
    def item_params
      params.require(:item).permit(:name, :merchant_id, :description, :unit_price)
    end
end