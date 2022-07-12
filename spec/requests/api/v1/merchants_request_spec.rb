require 'rails_helper'

RSpec.describe 'Merchants Endpoints' do 
  describe 'get all merchants' do 
    context 'happy path' do 
      it 'sends a list of merchants' do 
        merchant_list = create_list(:merchant, 5)

        get '/api/v1/merchants'

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants[:data].count).to eq(5)
        expect(merchants[:data]).to be_an(Array)
        expect(merchants[:data][0][:attributes][:name]).to eq(merchant_list.first.name)

        merchants[:data].each do |merchant|
        # binding.pry

          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_an(String)

          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant[:attributes][:name]).to be_a(String)

          expect(merchant[:attributes]).to_not have_key(:created_at)
        end
      end
    end
  end

  describe 'get one merchant endpoint' do 
    context 'happy path' do 
      it 'sends information for the specific merchant requested' do 
        merchant_list = create_list(:merchant, 3)

        get "/api/v1/merchants/#{merchant_list[0].id}"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        merchant = JSON.parse(response.body, symbolize_names: true)
        #  binding.pry

        expect(merchant[:data].keys.length).to eq(3)
        expect(merchant[:data][:id].to_i).to eq(merchant_list.first.id)
        expect(merchant[:data][:attributes][:name]).to eq(merchant_list.first.name)
      end
    end
  end
end