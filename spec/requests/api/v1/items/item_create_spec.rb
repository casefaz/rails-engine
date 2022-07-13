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
      expect(response).to be_successful
      expect(response).to have_http_status(201)

      parsed_created_item = JSON.parse(response.body, symbolize_names: true)
      # binding.pry
      expect(parsed_created_item[:data][:id].to_i).to eq(created_item.id)
      expect(parsed_created_item[:data][:attributes][:name]).to eq(created_item.name)
      expect(parsed_created_item[:data][:attributes][:description]).to eq(created_item.description)
    end
  end
end