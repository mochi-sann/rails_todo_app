# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
10.times do |i|
  Todo.find_or_create_by!(title: "Sample Post #{i + 1}",  done: rand(2)==1)
end

User.find_or_create_by!(email_address: "dev_user1@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  # user.name = "開発ユーザー1"
end

User.find_or_create_by!(email_address: "dev_user2@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  # user.name = "開発ユーザー2"
end

User.find_or_create_by!(email_address: "dev_user3@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  # user.name = "開発ユーザー3"
end
