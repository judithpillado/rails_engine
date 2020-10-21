class InvoiceItem < ApplicationRecord
  validates :quantity, numericality: true
  validates :unit_price, presence: true
  belongs_to :item
  belongs_to :invoice
end
