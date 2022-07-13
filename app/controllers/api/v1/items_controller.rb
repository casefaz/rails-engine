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

  private
    def item_params
      params.require(:item).permit(:name, :merchant_id, :description, :unit_price)
    end
end