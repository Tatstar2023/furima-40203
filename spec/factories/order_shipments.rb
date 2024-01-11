FactoryBot.define do
  factory :order_shipment do
    token { 'tok_abcdefghijk00000000000000000' }
    postcode { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    house_number { '1-1' }
    building_name { '東京ハイツ' }
    telephone { '09011111111' }
  end
end
