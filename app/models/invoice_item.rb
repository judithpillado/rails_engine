class InvoiceItem < ApplicationRecord
  validates :quantity, numericality: true
  validates :unit_price, presence: true
  belongs_to :item
  belongs_to :invoice

  def pennies_to_dollars
    unit_price / 100.0
  end
end
