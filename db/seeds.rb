# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")
user2 = User.where(email: "test2@example.com").first_or_create(password: "password", password_confirmation: "password")

charlie_rappers = [
  {
    name:'Charla Mae',
    genre:'Heavy Metal',
    songs:'In Da Code, Code Playing Tricks on Me',
    awards:3,
    price:'$70/hr', 
    rating:4.4,
    image:'https://freesvg.org/img/cyberscooty-hip_hop_kid_2.png'
  },{
    name:'Nicod',
    genre:'Classical',
    songs:'Code Takes Two, It Was a Code Day',
    awards:3,
    price:'$68/hr', 
    rating:4.4,
    image:'https://freesvg.org/img/cyberscooty-hip_hop_kid_1.png'
  }
]

freelance_rappers = [
  {
    name:'DOAX',
    genre:'Gangsta Rap',
    songs:'Can Code This, Nothing But a Code Thang',
    awards:5,
    price:'$80/hr', 
    rating:4.9,
    image:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLY73XNvTkFW9UpjV5sVczHTvYJpcZZOEyaQ&usqp=CAU'
  } 
]

charlie_rappers.each do |rapper|
  user1.rappers.create(rapper)
  puts "creating: #{rapper}"
end

freelance_rappers.each do |rapper|
  user2.rappers.create(rapper)
  puts "creating: #{rapper}"
end