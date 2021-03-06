# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Get Merchant Items' do
  describe 'get the endpoints for the items belonging to a merchant' do
    context 'happy path' do
      it 'successfully produces the information' do
        merchants = create_list(:merchant, 2)
        items = create_list(:item, 5, merchant: merchants[0])

        get "/api/v1/merchants/#{merchants[0].id}/items"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        parsed_items = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_items[:data].count).to eq(5)
        expect(parsed_items[:data][0][:attributes][:name]).to eq(items.first.name)
        expect(parsed_items[:data][0].keys.length).to eq(3)
        expect(parsed_items[:data][0][:attributes].keys.length).to eq(4)

        parsed_items[:data].each do |item|
          expect(item).to have_key(:id)
          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes]).to have_key(:merchant_id)
          expect(item[:attributes]).to have_key(:description)
          expect(item[:attributes]).to have_key(:unit_price)
          expect(item[:attributes]).to_not have_key(:created_at)
        end
      end
    end

    context 'sad path' do
      it 'returns a 404 error with bad merchant id' do
        merchants = create_list(:merchant, 2)
        items = create_list(:item, 3, merchant: merchants[0])

        get '/api/v1/merchants/54920/items'

        expect(response).to have_http_status(404)
      end
    end
  end
end
