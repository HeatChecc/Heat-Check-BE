# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_1 = User.create!(username: 'eli', email: 'eli@eli.com')
user_2 = User.create!(username: 'phil', email: 'phil@phil.com')
user_3 = User.create!(username: 'ethan', email: 'ethan@ethan.com')
user_4 = User.create!(username: 'gauri', email: 'gauri@gauri.com')

# data = {
#   "user_1": {
#     "username": "eli",
#     "email": "eli@eli.com"
#   },
#   "user_2": {
#     "username": "phil",
#     "email": "phil@phil.com"
#   },
#   "user_3": {
#     "username": "ethan",
#     "email": "ethan@ethan.com"
#   },
#   "user_4": {
#     "username": "gauri",
#     "email": "gauri@gauri.com"
#   }
# }
