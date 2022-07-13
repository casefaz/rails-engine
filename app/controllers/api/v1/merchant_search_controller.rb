# frozen_string_literal: true

module Api
  module V1
    class MerchantSearchController < ApplicationController
      def show
        binding.pry

        # if params[:name]
          merchant = Merchant.find(params[:name])
          render json: MerchantSerializer.new(merchant)
        # end
      end
    end
  end
end
