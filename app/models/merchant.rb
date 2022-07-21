# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.search_by_name(query)
    where('name ILIKE ?', "%#{query}%")
      .order(:name)
      .first
  end

  def self.top_merchants(quantity)
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .select(:name, :id, 'SUM(invoice_items.quantity*invoice_items.unit_price) as revenue')
    .group(:id)
    .order(revenue: :desc)
    .limit(quantity)
  end
end
