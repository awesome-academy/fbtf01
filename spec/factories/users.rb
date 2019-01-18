FactoryBot.define do
  factory :user do
    name{Faker::Name.name}
    email{Faker::Internet.email}
    password{"password"}
    phone{"0123456789"}
  end
end
