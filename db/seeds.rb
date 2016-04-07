# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
User.create(user_name: 'A', user_email: 'a@gmail.com', organization: "CSUA", admin_status: true, user_prime: 2, votes: '{"csua_04012016_President":"3"}')
User.create(user_name: 'B', user_email: 'b@gmail.com', organization: "CSUA", admin_status: true, user_prime: 3, votes: '{"csua_04012016_President":"3"}')
User.create(user_name: 'B', user_email: 'b@gmail.com', organization: "HKN", admin_status: false, user_prime: 5, votes: '{"hkn_04012016_President":"7"}')
User.create(user_name: 'C', user_email: 'c@gmail.com', organization: "HKN", admin_status: true, user_prime: 7, votes: '{"hkn_04012016_President":"7"}')
User.create(user_name: 'D', user_email: 'd@gmail.com', organization: "CSUA", admin_status: true, user_prime: 11, votes: '{}')
User.create(user_name: 'E', user_email: 'e@gmail.com', organization: "HKN", admin_status: true, user_prime: 13, votes: '{}')


Election.create(election_livestream: '', election_id: 'csua_04012016', election_name: 'csua1', organization: 'CSUA', position: "President", user_id: "a@gmail.com", num_votes: 0, did_win: false)
#Nomination.create(election_id: 'csua_04012016', organization: 'CSUA', position: "President", threshold: 2, user_id: "a@gmail.com", num_seconds: 0, prime_product: 1)

# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
