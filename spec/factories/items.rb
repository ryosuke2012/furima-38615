FactoryBot.define do
  factory :item do
    name {Faker::Name.name}
    description {"説明文"}
    price {10000}
    category_id {2}
    condition_id {2}
    shipping_fee_id {2}
    region_id {2}
    delivery_time_id {2}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end