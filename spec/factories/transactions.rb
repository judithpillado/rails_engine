FactoryBot.define do
  factory :transaction do
    association :invoice
    credit_card_number { Faker::Number.number(digits: 16) }
    result { 'success' }
  end
end
