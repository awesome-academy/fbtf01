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
  name = Faker::OnePiece.character
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

20.times do |n|
  name = Faker::Nation.capital_city
  description = Faker::Lorem.paragraph_by_chars 256, false
  location = Location.create!(
    name: name,
    description: description)
  3.times do |n|
    image = Image.new location_id: location.id
    image_src = File.open File.join(Rails.root, "public/seed/#{n + 1}.jpg")
    src_file = File.new image_src
    image.url = src_file
    image.save!
  end
end
