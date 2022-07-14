class Api::V1::ItemsSearchController < ApplicationController
  def show
    if valid_query?
      if params[:name]
        item = Item.find_name(params[:name])
        render json: ItemSerializer.new(item)
      elsif params[:min_price]
        item = Item.find_min_price(params[:unit_price].to_f)
        render json: ItemSerializer.new(item)
      elsif params[:max_price]
        item = Item.find_max_price(params[:unit_price])
        render json: ItemSerializer.new(item)
      elsif params[:min_price] && params[:max_price]
        item = Item.find_min_and_max_price(params[:unit_price])
        render json: ItemSerializer.new(item)
      end
    end
  end

  def valid_query?
    name = params[:name] != '' && !params[:min_price] && !params[:max_price]
    min_or_max = !params[:name] && (params[:min_price] != nil || params[:max_price] != nil)
    min_and_max_price = !params[:name] && params[:min_price] != nil && params[:max_price] != nil

    name || min_or_max || min_and_max_price
  end
end
