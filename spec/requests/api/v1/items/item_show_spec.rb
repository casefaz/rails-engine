require 'rails_helper'

RSpec.describe 'Item Show' do 
  describe 'a single item fetch' do 
    context 'happy path' do 
      it 'produces the correct data' do 
        items = create_list(:item, 3)

        get "/api/v1/items/#{items[0].id}"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        parsed_item = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_item[:data][:attributes][:name]).to eq(items[0].name)
        expect(parsed_item[:data].count).to eq(3)
        expect(parsed_item[:data][:attributes].keys.count).to eq(4)
        expect(parsed_item[:data][:id].to_i).to eq(items.first.id)
        expect(parsed_item[:data][:attributes][:name]).to eq(items.first.name)
      end
    end

    context 'sad path' do 
      it 'returns an error with a bad id' do 
        get '/api/v1/items/9043'

        expect(response).to have_http_status(404)
      end

      it 'returns an error if the id is a string' do 
        get "/api/v1/items/'1'"

        expect(response).to have_http_status(404)
      end
    end
  end
end