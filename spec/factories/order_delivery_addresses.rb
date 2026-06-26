FactoryBot.define do
  factory :order_delivery_address do
    token         { 'tok_abcdefghijk00000000000000000' }
    postal_code   { '123-4567' }
    prefecture_id { 3 }
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building      { Faker::Address.secondary_address }
    phone_number  { '09012345678' }
  end
end
