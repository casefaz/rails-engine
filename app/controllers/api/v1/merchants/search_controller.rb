# frozen_string_literal: true

module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        def index
          if params[:name] && params[:name] != ''
            merchant = Merchant.search_by_name(params[:name])
            if merchant
              render json: MerchantSerializer.new(merchant)
            else
              render json: { data: {}, message: 'No matches' }, status: :ok
            end
          else
            render json: { response: 'Bad Request' }, status: :bad_request
          end
        end
      end
    end 
  end
end
