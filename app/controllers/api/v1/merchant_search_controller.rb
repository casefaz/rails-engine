# frozen_string_literal: true

module Api
  module V1
    class MerchantSearchController < ApplicationController
      def show
        if params[:name] != ''
          merchant = Merchant.search_by_name(params[:name])
          if merchant
            render json: MerchantSerializer.new(merchant)
          else
            render json: { data: {}, message: 'No matches' }, status: :ok
          end
        end
      end
    end
  end
end
