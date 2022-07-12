require 'rails_helper'

RSpec.describe 'Get Merchant Items' do 
  describe 'get the endpoints for the items belonging to a merchant' do 
    context 'happy path' do 
      it 'successfully produces the information' do 
        merchants = create_list(:merchant, 2)
        items = create_list(:item, 5, merchant: merchants[0])
        # binding.pry
        get "/api/v1/merchants/#{merchants[0].id}/items"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        items = JSON.parse(response.body, symbolize_names: true)
        binding.pry
      end 
    end
  end
end