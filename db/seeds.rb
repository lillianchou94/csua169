# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

Election.create(election_id: 'csua_04012016', election_name: 'CSUA', election_time: DateTime.new(2001,2,3), position: "prezzz", candidate: "me", total_votes: 3, num_won: 3)
Election.create(election_id: 'csua_04012016_1', election_name: 'CSUA', election_time: DateTime.new(2001,2,4), position: "sec", candidate: "me2", total_votes: 3, num_won: 2)
Election.create(election_id: 'csua_04012016_2', election_name: 'CSUA', election_time: DateTime.new(2001,2,5), position: "peasant", candidate: "me3", total_votes: 3, num_won: 2)

# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
