# Users
User.create!(
  name: "Admin",
  email: "tour_booking_admin@framgia.com",
  password: "foobar123",
  password_confirmation: "foobar123",
  address: "Framgia Inc.",
  phone: "0123456789",
  role: 1)

User.create!(
  name: "Nguyen Luong Huy",
  email: "nguyen.luong.huy@framgia.com",
  password: "foobar123",
  password_confirmation: "foobar123",
  address: "Framgia Inc.",
  phone: "0858653568",
  role: 0)

20.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  address = Faker::Address.full_address
  phone = rand(10 ** 10).to_s.rjust 10, "0"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    address: address,
    phone: phone,
    role: 0)
end
