require 'rails_helper'

RSpec.describe 'Item Show' do 
  describe 'a single item fetch' do 
    context 'happy path' do 
      it 'produces the correct data' do 
        items = create_list(:item, 3)

        get "/api/v1/items/#{items[0].id}"

        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end
  end
end