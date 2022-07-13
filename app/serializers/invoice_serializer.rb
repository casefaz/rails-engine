# frozen_string_literal: true

class InvoiceSerializer
  include JSONAPI::Serializer
  attributes :status
end
