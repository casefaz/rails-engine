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

        expect(merchants.count).to eq(5)
        expect(merchants).to be_an(Array)
        expect(merchants[0][:name]).to eq(merchant_list.first.name)
        
        merchants.each do |merchant|
          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_an(Integer)

          expect(merchant).to have_key(:name)
          expect(merchant[:name]).to be_a(String)
        end
      end
    end
  end
end