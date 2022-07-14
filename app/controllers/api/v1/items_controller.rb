# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      def index
        render json: ItemSerializer.new(Item.all)
      end

      def show
        item = Item.find(params[:id])
        render json: ItemSerializer.new(item)
      end

      def create
        new_item = Item.create!(item_params)
        render json: ItemSerializer.new(new_item), status: :created
      end

      def destroy
        render json: Item.find(params[:id]).destroy
      end

      def update
        if Item.exists?(params[:id])
          item = Item.update(params[:id], item_params)
          if item.save
            render json: ItemSerializer.new(item)
          else
            render status: 404
          end
        else
          render status: 404
        end
      end

      # def only items (possibly model class method) - delete an item if it's not the only thing on the invoice, OR delete the whole invoice if it only has that item on it

      private

      def item_params
        params.require(:item).permit(:name, :merchant_id, :description, :unit_price)
      end
    end
  end
end
