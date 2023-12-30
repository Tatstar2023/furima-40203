FactoryBot.define do
  factory :item do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    category { Category.where.not(id: 0).sample }
    condition { Condition.where.not(id: 0).sample }
    shippingfee { Shippingfee.where.not(id: 0).sample }
    shippingorigin { Shippingorigin.where.not(id: 0).sample }
    shippingleadtime { Shippingleadtime.where.not(id: 0).sample }
    price { Faker::Number.within(range: 300..1000) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
