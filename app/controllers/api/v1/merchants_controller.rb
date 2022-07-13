# frozen_string_literal: true

module Api
  module V1
    class MerchantsController < ApplicationController
      def index
        render json: MerchantSerializer.new(Merchant.all)
      end

      def show
        if Item.exists? && params[:item_id]
          merchant = Item.find(params[:item_id]).merchant
          render json: MerchantSerializer.new(merchant)
        else
          merchant2 = Merchant.find(params[:id])
          render json: MerchantSerializer.new(merchant2)
        end
      end
    end
  end
end
