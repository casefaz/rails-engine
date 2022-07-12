require 'rails_helper'

RSpec.describe 'Items Index' do 
  describe 'fetch all items' do
    it 'produces data' do 
      items = create_list(:item, 5)
      
      get "/api/v1/items"

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end 
  end
end