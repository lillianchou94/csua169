# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

Election.create(election_id: 'first election', election_time: DateTime.new(2001,2,3), position: "prezzz", candidate: "me", total_votes: 3, num_won: 3)
Election.create(election_id: 'second election', election_time: DateTime.new(2001,2,4), position: "sec", candidate: "me2", total_votes: 3, num_won: 2)
Election.create(election_id: 'third election', election_time: DateTime.new(2001,2,5), position: "peasant", candidate: "me3", total_votes: 3, num_won: 2)

# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
