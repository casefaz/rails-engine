# frozen_string_literal: true

module Api
  module V1
    class MerchantSearchController < ApplicationController
      def show
        # binding.pry
          merchant = Merchant.search_by_name(params[:name])
          render json: MerchantSerializer.new(merchant)
      end
    end
  end
end
