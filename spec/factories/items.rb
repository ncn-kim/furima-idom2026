FactoryBot.define do
  factory :item do
    name { Faker::Lorem.characters(number: 40) }
    detail { Faker::Lorem.characters(number: 1000) }
    price { rand(300..9_999_999) }

    category_id { 2 }
    sales_status_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    schedule_id { 2 }

    association :user

    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('public/images/test_image.png')),
        filename: 'test_image.png'
      )
    end
  end
end
