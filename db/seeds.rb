# Users
email = "tour_booking_admin@framgia.com"
User.create!(
  name: "Admin",
  email: email,
  password: "foobar123",
  password_confirmation: "foobar123",
  address: "Framgia Inc.",
  phone: "0123456789",
  role: 1)

email = "nguyen.luong.huy@framgia.com"
User.create!(
  name: "Nguyen Luong Huy",
  email: email,
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

# Locations with Images
10.times do |n|
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

# Categories
cultural = Category.create!(name: "Cultural")
festival = Category.create!(name: "Festival")

Category.create!(
  name: "Discovery",
  parent_id: cultural.id)

Category.create!(
  name: "Historical",
  parent_id: cultural.id)

Category.create!(
  name: "Christmas",
  parent_id: festival.id)

Category.create!(
  name: "New Year",
  parent_id: festival.id)

# Tours
20.times do |n|
  name = Faker::Book.title
  description = Faker::Lorem.paragraph_by_chars 256, false
  date_from = Faker::Date.forward 3
  date_to = Faker::Date.between 3.days.from_now, 7.days.from_now
  min_passengers = rand 5..10
  max_passengers = min_passengers + 10
  price = rand 50..200
  category_id = rand 3..6
  Tour.create!(
    name: name,
    description: description,
    date_from: date_from,
    date_to: date_to,
    min_passengers: min_passengers,
    max_passengers: max_passengers,
    price: price,
    category_id: category_id)
end

# Occurrences
location_id = 1
Tour.all.each do |tour|
  rand(2..3).times do |n|
    Occurrence.create!(
      tour_id: tour.id,
      location_id: location_id)
    location_id += 1
    location_id = 1 if location_id > 10
  end
end
