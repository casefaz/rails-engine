# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Find a Merchant' do
  describe 'Returns a single result' do
    it 'can filter merchants by search' do
      merchant = create(:merchant, name: 'Otaku Attic')
      merchant2 = create(:merchant, name: 'Barnes and Noble')

      get "/api/v1/merchants/find?name=otaku"

      expect(response).to be_successful
      expect(response).to have_http_status(400)
    end
  end
end
