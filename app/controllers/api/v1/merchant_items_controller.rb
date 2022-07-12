class Api::V1::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    render json: MerchantSerializer.new(merchant.items)
  end
end