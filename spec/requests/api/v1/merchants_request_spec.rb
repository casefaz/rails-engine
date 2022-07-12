require 'rails_helper'

RSpec.describe 'Merchants Endpoints' do 
  describe 'get all merchants' do 
    it 'sends a list of merchants' do 
      create_list(:merchant, 5)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body)
    end
  end
end