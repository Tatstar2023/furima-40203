FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.email}
    password {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    first_name_zenkaku { Faker::Japanese::Name.first_name }
    last_name_zenkaku { Faker::Japanese::Name.last_name }
    first_name_katakana { first_name_zenkaku.to_kanhira.to_kana }
    last_name_katakana { last_name_zenkaku.to_kanhira.to_kana }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end