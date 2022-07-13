require 'rails_helper'

RSpec.describe 'Update Item' do 
  describe 'the things that happen in an update' do 
    context 'happy path' do 
      it 'updates the item with partial information' do 
        item = create(:item)
        previous_name = Item.last.name
        item_params = { name: "Super Cool Model Ship"}
        headers = { "CONTENT_TYPE" => "application/json" }

        patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})
        item = Item.find_by(id: item.id)

        expect(response).to be_successful
        expect(item.name).to_not eq(previous_name)
        expect(item.name).to eq("Super Cool Model Ship")

        parsed_updated_item = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_updated_item[:data].keys.count).to eq(3)
        expect(parsed_updated_item[:data][:attributes].keys.count).to eq(4)
        expect(parsed_updated_item[:data][:attributes][:name]).to eq(item.name)
      end

      it 'updates with all the attributes' do 
        merchant = create(:merchant)
        item = create(:item)
        previous_name = Item.last.name
        item_params = { 
                        name: "Super Cool Model Ship",
                        description: 'a model ship from anime one piece',
                        unit_price: 102.45,
                        merchant_id: merchant.id
                      }
        headers = { "CONTENT_TYPE" => "application/json" }

        patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})
        item = Item.find_by(id: item.id)

        expect(response).to be_successful
        expect(item.name).to_not eq(previous_name)
        expect(item.name).to eq("Super Cool Model Ship")
        expect(item.unit_price).to eq(102.45)
        expect(item.description).to eq('a model ship from anime one piece')

        parsed_updated_item = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_updated_item[:data].keys.count).to eq(3)
        expect(parsed_updated_item[:data][:attributes].keys.count).to eq(4)
        expect(parsed_updated_item[:data][:attributes][:name]).to eq(item.name)
      end
    end 
  end
end