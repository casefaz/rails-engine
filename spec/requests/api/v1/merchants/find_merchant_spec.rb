# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Find a Merchant' do
  describe 'Returns a single result' do
    context 'happy path' do
      it 'can filter merchants by search' do
        merchant = create(:merchant, name: 'Otaku Attic')
        merchant2 = create(:merchant, name: 'Barnes and Noble')

        get '/api/v1/merchants/find?name=otaku'

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        found_merchant = JSON.parse(response.body, symbolize_names: true)

        expect(found_merchant[:data][:attributes][:name]).to eq(merchant.name)
        expect(found_merchant[:data][:attributes][:name]).to eq(merchant.name)
        expect(found_merchant[:data].count).to eq(3)
        expect(found_merchant[:data][:attributes].count).to eq(1)
      end
    end

    context 'sad path' do
      it 'produces an empty json object if no path matches' do
        get '/api/v1/merchants/find?name=marypoppinscarpetbag'

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        no_data = JSON.parse(response.body, symbolize_names: true)

        expect(no_data[:data]).to eq({})
        expect(no_data[:message]).to eq('No matches')
      end
    end
  end
end
