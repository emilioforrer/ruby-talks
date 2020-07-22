# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

emails = [
  ["john@example.com",  "John Doe"],
  ["jane@example.com",  "Jane Doe"]
]

emails.each do |fields|
  email = fields.first
  name = fields.last
  user = User.find_by(email: email) || User.new(email: email)
  user.name = name
  user.password = "Password123"
  user.setup_activation
  user.activate!
  user.save
end

5.times do
  contact = Contact.new
  contact.name = Faker::TvShows::GameOfThrones.character
  5.times do
    address = contact.addresses.build
    address.description = "#{Faker::TvShows::GameOfThrones.city}, #{Faker::TvShows::GameOfThrones.house}"
    phone = contact.phones.build
    phone.number = "#{Faker::PhoneNumber.phone_number}"
    email = contact.emails.build
    email.account = "#{Faker::Internet.email}"
  end
  contact.save
end