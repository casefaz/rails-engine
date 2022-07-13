# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.search_by_name(query)
    where("name ILIKE ?", "%#{query}%")
    .order(:name)
    .first
  end
end
