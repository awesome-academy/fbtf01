FactoryBot.define do
  factory :admin, class: User do
    name{Faker::Name.name}
    email{Faker::Internet.email}
    password{"password"}
    phone{"0123456789"}
    role{"admin"}
  end

  factory :user do
    name{Faker::Name.name}
    email{Faker::Internet.email}
    password{"password"}
    phone{"0123456789"}
  end
end
