class Election < ActiveRecord::Base
    #self.table_name = "elections"
    # belongs_to :users
    attr_accessible :users_id, :created_by, :phase, :election_name, :election_id, :election_livestream, :election_time, :organization, :position, :user_id, :num_votes, :did_win, :phase

end
