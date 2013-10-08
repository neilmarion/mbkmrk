# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 100000289242843

user = User.first
picture = "http://external.ak.fbcdn.net/safe_image.php?d=AQCKjEYi1MY4CaDA&w=154&h=154&url=http%3A%2F%2Fezimg.it%2Ff%2Ftpb_afk%2Fthumbnail.png"
link = "http://anc.yahoo.com/news/pnoy--misuari-to-face-charges-on-illegal-possession-of-explosives-013649593.html"

for i in 1..20
  user.posts.create!(uid: i, message: Faker::Lorem.sentence, picture: picture, link: link, source: link, post_link: link, tag_list: "#tag, #bag")
  puts "hello"
end
