# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
User.create!(name:  "Admin User",
             email: "admin@gmail.com",
             password:              "admin_ytu",
             password_confirmation: "admin_ytu",
             admin: true)

User.create!(name:  "selim1",
             email: "selim1@gmail.com",
             password:              "selim1",
             password_confirmation: "selim1",
             admin: true)

Role.create(role_type: "Director")
Role.create(role_type: "Writer")
Role.create(role_type: "Actor")

# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

# 99.times do |n|
#   name = Faker::Name.name
#   email = "example-#{n+1}@example.com"
#   password = "password"
#   User.create!(name:  name,
#                email: email,
#                password:              password,
#                password_confirmation: password)
# end
