# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items Index' do
  describe 'fetch all items' do
    it 'produces data' do
      items = create_list(:item, 5)

      get '/api/v1/items'

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      parsed_items = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_items[:data].count).to eq(5)
      expect(parsed_items[:data]).to be_an(Array)
      expect(parsed_items[:data][0]).to_not have_key(:relationships)
      expect(parsed_items[:data][0][:attributes][:name]).to eq(items.first.name)
      expect(parsed_items[:data][0].keys.length).to eq(3)
      expect(parsed_items[:data][0][:attributes].keys.length).to eq(4)

      parsed_items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes]).to have_key(:merchant_id)
      end
    end
  end
end
