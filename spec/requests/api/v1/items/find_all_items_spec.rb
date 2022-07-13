require 'rails_helper'

RSpec.describe 'Find All Items' do 
  describe 'producing correct information' do 
    context 'happy path' do 
      it 'successfully finds all the items related to a search' do 
        item1 = create(:item, name: 'white rice')
        item2 = create(:item, name: 'brown rice')
        item3 = create(:item, name: 'fried rice')
        item4 = create(:item, name: 'sesame ball')

        get "/api/v1/items/find_all?name=rice"

        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end
  end
end