# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items, dependent: :destroy

  def self.find_name(query)
    where('name ILIKE ?', "%#{query}%")
  end

  def self.find_min_price(price)
    where('unit_price >= ?', "#{price}")
  end

  def self.find_max_price(price)
    where('unit_price <= ?', "#{price}")
  end

  def self.find_min_and_max_price(min_price, max_price)
    where("unit_price >= #{min_price} AND unit_price <= #{max_price}")
  end
end
