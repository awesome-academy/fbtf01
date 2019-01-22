FactoryBot.define do
  factory :admin, class: User do
    name{Faker::Name.name}
    email{Faker::Internet.email}
    password{"password"}
    address{Faker::Address.full_address}
    phone{"0123456789"}
    role{"admin"}
  end

  factory :user do
    name{Faker::Name.name}
    email{Faker::Internet.email}
    password{"password"}
    address{Faker::Address.full_address}
    phone{"0123456789"}
  end
end
