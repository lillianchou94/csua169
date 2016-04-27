# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
User.create(user_name: 'A', user_email: 'a@gmail.com', organization: "CSUA", admin_status: 1, user_prime: 2, is_active: true, votes: '{"csua_04012016_President":"3"}')
User.create(user_name: 'B', user_email: 'b@gmail.com', organization: "CSUA", admin_status: 1, user_prime: 3, is_active: true, votes: '{"csua_04012016_President":"3"}')
User.create(user_name: 'B', user_email: 'b@gmail.com', organization: "HKN", admin_status: 1, user_prime: 5, is_active: true, votes: '{"hkn_04012016_President":"7"}')
User.create(user_name: 'C', user_email: 'c@gmail.com', organization: "HKN", admin_status: 0, user_prime: 7, is_active: true, votes: '{"hkn_04012016_President":"7"}')
User.create(user_name: 'D', user_email: 'd@gmail.com', organization: "CSUA", admin_status: 0, user_prime: 11, is_active: true, votes: '{}')
User.create(user_name: 'E', user_email: 'e@gmail.com', organization: "HKN", admin_status: 0, user_prime: 13, is_active: true, votes: '{}')
User.create(user_name: 'Lillian Chou', user_email: 'lillianchou94@gmail.com', organization: "CSUA", admin_status: 1, user_prime: 17, is_active: true, votes: '{}')
User.create(user_name: 'Lillian Chou', user_email: 'lillianchou94@gmail.com', organization: "HKN", admin_status: 1, user_prime: 19, is_active: true, votes: '{}')
User.create(user_name: 'MELANIE ELIZABETH TOM', user_email: 'melanietom@berkeley.edu', organization: "CSUA", admin_status: 1, user_prime: 23, is_active: true, votes: '{}')
User.create(user_name: 'Rashmi Vidyasagar', user_email: 'rashmi.vidyasagar@berkeley.edu', organization: "HKN", admin_status: 2, user_prime: 29, is_active: true, votes: '{}')
User.create(user_name: 'Rashmi Vidyasagar', user_email: 'rashmi.vidyasagar@berkeley.edu', organization: "CSUA", admin_status: 2, user_prime: 31, is_active: true, votes: '{}')
User.create(user_name: 'Jason Edward Lee', user_email: 'jasonlee17@berkeley.edu', organization: "CSUA", admin_status: 1, user_prime: 37, is_active: true, votes: '{}')
User.create(user_name: 'Shayanth Sinnarajah', user_email: 'ssinnarajah@berkeley.edu', organization: "HKN", admin_status: 1, user_prime: 41, is_active: true, votes: '{}')

User.create(user_name: 'CSUA Member', user_email: 'member169csua@gmail.com', organization: "CSUA", admin_status: 0, user_prime: 43, is_active: true, votes: '{}')
User.create(user_name: 'CSUA Admin', user_email: 'email1111222@gmail.com', organization: "CSUA", admin_status: 1, user_prime: 47, is_active: true, votes: '{}')
User.create(user_name: 'HKN Admin', user_email: 'hknadmin@gmail.com', organization: "HKN", admin_status: 1, user_prime: 53, is_active: true, votes: '{}')
User.create(user_name: 'Super Admin', user_email: 'super169csua@gmail.com', organization: "CSUA", admin_status: 2, user_prime: 59, is_active: true, votes: '{}')


Election.create(election_livestream: '', election_id: 'csua_04012016', election_name: 'csua1', organization: 'CSUA', position: "President", user_id: "a@gmail.com", num_votes: 0, did_win: false)
#Nomination.create(election_id: 'csua_04012016', organization: 'CSUA', position: "President", threshold: 2, user_id: "a@gmail.com", num_seconds: 0, prime_product: 1)

# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
