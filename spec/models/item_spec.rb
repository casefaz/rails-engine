# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant }
  it { should have_many :invoice_items }
  it { should have_many(:items).through(:invoice_items) }

  describe 'class methods' do
    it '.find_name(string)' do
      item1 = create(:item, name: 'white rice')
      item2 = create(:item, name: 'brown rice')
      item3 = create(:item, name: 'fried rice')
      item4 = create(:item, name: 'sesame ball')
      query = 'rice'

      expect(Item.find_name(query)).to eq([item1, item2, item3])
      expect(Item.find_name(query)).to_not include([item4])
    end

    it '.find_min_price(price)' do 
      item1 = create(:item, name: 'white rice', unit_price: 1.00)
      item2 = create(:item, name: 'brown rice', unit_price: 2.00)
      item3 = create(:item, name: 'fried rice', unit_price: 3.00)
      item4 = create(:item, name: 'sesame ball', unit_price: 4.00)
      price = 2.00

      expect(Item.find_min_price(price)).to eq([item1, item2])
      expect(Item.find_min_price(price)).to_not include([item3, item4])
    end
  end
end
