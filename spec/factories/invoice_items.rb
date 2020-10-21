FactoryBot.define do
  factory :invoice_item do
    association :item
    association :invoice
    quantity { rand(1..10) }
    unit_price { rand(100..1000) }
  end
end
