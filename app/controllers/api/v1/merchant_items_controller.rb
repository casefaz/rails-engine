class Api::V1::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    # binding.pry
    render json: ItemSerializer.new(merchant.items)
  end
end