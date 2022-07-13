require 'rails_helper'

RSpec.describe 'Item Create' do 
  describe 'creating a new item' do 
    it 'is a success!' do 
      merchant = create(:merchant)

      item_params = ({
        name: 'Gurren Lagann Gundam',
        description: 'buildable model from the gurren lagann series',
        unit_price: 89.91,
        merchant_id: merchant.id
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      expect(merchant.items).to eq([])

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
      created_item = Item.last
        # binding.pry
      expect(response).to be_successful
      expect(response).to have_http_status(201)
    end
  end
end