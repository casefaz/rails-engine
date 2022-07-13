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
      end
    end
  end
end