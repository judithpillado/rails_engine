class Transaction < ApplicationRecord
  validates :credit_card_number, numericality: true
  validates :result, presence: true
  belongs_to :invoice
end
