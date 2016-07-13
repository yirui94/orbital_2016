# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!( name: "Example User",
				email: "example@railstutorial.org",
				password: "foobar78",
				password_confirmation: "foobar78",
				admin: true,
				activated: true,
				activated_at: Time.zone.now)

99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@railstutorial.org"
	password = "password"
	User.create!(name: name,
					email: email,
					password: password,
					password_confirmation: password,
					activated: true,
    				activated_at: Time.zone.now)
end

users = User.order(:created_at)
users.each do |user|
	user.create_user_detail(introduction: 'introPH', country: 'AL', medium: 'Oil' )
end

users = User.order(:created_at).take(6)
users.each do |user|
	user.create_user_detail(introduction: 'introPH', country: 'AF', medium: 'Watercolour' )
end

10.times do
	title = Faker::Book.title
	content = Faker::Lorem.sentence(5)
	medium = 'Acrylic'
	width = Faker::Number.between(10, 50)
	height = Faker::Number.between(10, 50)
	price = Faker::Commerce.price
	users.each do |user| 
		picture = Faker::Placeholdit.image
		user.micropost.create!(title: title, content: content, remote_picture_url: picture, medium: medium, width: width, height: height, price: price)
	end
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed)}
followers.each { |follower| follower.follow(user)}
