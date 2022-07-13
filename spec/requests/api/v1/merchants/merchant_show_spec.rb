# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Merchant Show Page' do
  describe 'get a single merchant endpoint' do
    context 'happy path' do
      it 'sends information for the specific merchant requested' do
        merchant_list = create_list(:merchant, 3)

        get "/api/v1/merchants/#{merchant_list[0].id}"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(merchant[:data].keys.length).to eq(3)
        expect(merchant[:data][:attributes].length).to eq(1)
        expect(merchant[:data][:id].to_i).to eq(merchant_list.first.id)
        expect(merchant[:data][:attributes][:name]).to eq(merchant_list.first.name)
      end
    end

    context 'sad path' do
      it 'returns an error message if id doesnt exist' do
        merchant_id = 101

        get "/api/v1/merchants/#{merchant_id}"

        expect(response).to have_http_status(404)
      end
    end
  end
end
