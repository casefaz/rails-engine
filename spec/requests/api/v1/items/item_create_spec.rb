require 'rails_helper'

RSpec.describe 'Item Create' do 
  describe 'creating a new item' do 
    it 'is a success!' do 
      post '/api/v1/items'

      expect(response).to be_successful
      expect(response).to have_http_status(201)
    end
  end
end