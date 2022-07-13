# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many :items }
  it { should have_many :invoices }

  describe 'class methods' do 
    it '.search_by_name(query)' do 
      merchant1 = create(:merchant, name: 'Fancy Tiger')
      merchant2 = create(:merchant, name: 'FM')
      merchant3 = create(:merchant, name: 'Ti Cafe')
      query = 'fancy'

      expect(Merchant.search_by_name(query)).to eq(merchant1)
      expect(Merchant.search_by_name(query)).to_not eq([merchant2, merchant3])
    end
  end
end
