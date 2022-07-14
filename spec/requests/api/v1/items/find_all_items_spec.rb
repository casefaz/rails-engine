require 'rails_helper'

RSpec.describe 'Find All Items' do
  describe 'producing correct information' do
    context 'happy path' do
      it 'successfully finds all the items related to a search' do
        item1 = create(:item, name: 'white rice')
        item2 = create(:item, name: 'brown rice')
        item3 = create(:item, name: 'fried rice')
        item4 = create(:item, name: 'sesame ball')

        get '/api/v1/items/find_all?name=rice'

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        found_items = JSON.parse(response.body, symbolize_names: true)
        expect(found_items[:data].count).to eq(3)

        found_items[:data].each do |item|
          expect(item).to have_key(:id)
          expect(item[:attributes].keys.count).to eq(4)
          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes]).to have_key(:description)
          expect(item[:attributes]).to have_key(:merchant_id)
          expect(item[:attributes]).to have_key(:unit_price)
          expect(item[:attributes]).to_not have_key(:created_at)
        end
      end

      it 'can search by price params' do 
        item1 = create(:item, name: 'white rice', unit_price: 4.20)
        item2 = create(:item, name: 'brown rice', unit_price: 4.00)
        item3 = create(:item, name: 'fried rice', unit_price: 3.50)
        item4 = create(:item, name: 'sesame ball', unit_price: 100.23)

        get "/api/v1/items/find_all?"
      end
    end

    context 'sad path' do
      it 'produces an error if there is no match' do
        get '/api/v1/items/find_all?name=deckofmanythings'

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:message]).to eq('No matching items')
      end
    end
  end
end
