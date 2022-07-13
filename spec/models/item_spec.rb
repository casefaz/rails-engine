# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant }
  it { should have_many :invoice_items }
  it { should have_many(:items).through(:invoice_items) }

  describe 'class methods' do 
    it '.find_all_items(query)' do 
      item1 = create(:item, name: 'white rice')
      item1 = create(:item, name: 'brown rice')
      item3 = create(:item, name: 'fried rice')
      item4 = create(:item, name: 'sesame ball')
      query = 'rice'

      expect(Item.find_all_items(query)).to eq([item1, item2, item3])
      expect(Item.find_all_items(query)).to_not include([item4])
    end
  end
end
