# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.find_all_items(query)
    where("name ILIKE ?", "%#{query}%")
  end
end
