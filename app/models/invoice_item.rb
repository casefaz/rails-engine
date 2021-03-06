# frozen_string_literal: true

class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice, dependent: :destroy
end
