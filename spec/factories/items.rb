FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Dessert.variety }
    description { Faker::TvShows::MichaelScott.quote }
    unit_price { rand(100..1000) }
  end
end
