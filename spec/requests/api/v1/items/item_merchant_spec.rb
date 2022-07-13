# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items Merchant' do
  describe 'get one merchant by id' do
    context 'happy path' do
      it 'successfully produces a response' do
        merchant = create(:merchant)
        item = create(:item, merchant_id: merchant.id)

        get "/api/v1/items/#{item.id}/merchant"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        parsed_merchant = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_merchant[:data].keys.count).to eq(3)
        expect(parsed_merchant[:data][:attributes].count).to eq(1)
        expect(parsed_merchant[:data][:attributes][:name]).to eq(merchant.name)
      end
    end

    context 'sad path' do
      it 'returns an error with a bad item id' do
        get '/api/v1/items/45293/merchant'

        expect(response).to have_http_status(404)
      end

      it 'returns an error if the id comes through as a string' do
        get "/api/v1/items/'45293'/merchant"

        expect(response).to have_http_status(404)
      end
    end
  end
end
