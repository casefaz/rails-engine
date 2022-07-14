# frozen_string_literal: true

module Api
  module V1
    module Items
      class SearchController < ApplicationController
        def index
          if valid_query
            if params[:name] 
              item = Item.find_name(params[:name])
              render json: ItemSerializer.new(item)
            elsif params[:min_price] && params[:max_price]
              item = Item.find_min_and_max_price(params[:min_price], params[:max_price])
              render json: ItemSerializer.new(item)
            elsif params[:min_price]
              item = Item.find_min_price(params[:min_price])
              render json: ItemSerializer.new(item)
            elsif params[:max_price]
              item = Item.find_max_price(params[:max_price])
              render json: ItemSerializer.new(item)
            else
              render json: { response: 'Bad Request' }, status: :bad_request
            end
          else
            render json: { response: 'Bad Request' }, status: :bad_request
          end
        end

        def valid_query
          name = params[:name] != '' && !params[:min_price] && !params[:max_price]
          min_or_max = !params[:name] && (!params[:min_price].nil? || !params[:max_price].nil?)
          min_and_max_price = !params[:name] && (!params[:min_price].nil? && !params[:max_price].nil?)

          name || min_or_max || min_and_max_price
        end
      end 
    end
  end
end
