class Api::V1::ItemsSearchController < ApplicationController
  def show
    # binding.pry
    if params[:name] != ''
      item = Item.find_all_items(params[:name])
      if item.empty?
        # binding.pry
        render json: { data: [], message: 'No matching items' }
      else
        render json: ItemSerializer.new(item)
      end
    end
  end
end
