# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = User.create([{name: "Test User", image: "foo.com/jpg"}])
artists = Artist.create([{name: "Test Artist", image: "foo.com/band"}])
monthly_top_artists = MonthlyTopArtist.create([{month: 2.months.ago, user_id: users.first.id, artist_id: artists.first.id}])
