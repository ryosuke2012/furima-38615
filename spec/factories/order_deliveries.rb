FactoryBot.define do
  factory :order_delivery do
    postcode { '123-4567' }
    region_id { 2 }
    municipality { '東京都' }
    house_number { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { '08012345678' }
    item_id { 1 }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
