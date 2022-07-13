# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should have_many :transactions }
  it { should belong_to :customer }
  it { should belong_to :merchant }
end
