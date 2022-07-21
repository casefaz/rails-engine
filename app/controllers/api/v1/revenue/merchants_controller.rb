class Api::V1::Revenue::MerchantsController < ApplicationController
  def index 
    merchant = Merchant.top_merchants(params[:quantity])
    render json: MerchantNameRevenueSerializer.new(merchant)
  end
end