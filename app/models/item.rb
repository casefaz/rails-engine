# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.find_name(query)
    where('name ILIKE ?', "%#{query}%")
  end

  def self.find_min_price(price)
    where('unit_price <= ?', "#{price}")
  end
end
