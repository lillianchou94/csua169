class Election < ActiveRecord::Base
    self.table_name = "elections"
    #belongs_to :users
    attr_accessible :election_name, :election_id, :election_livestream, :election_time, :organization, :position, :user_id, :num_votes, :did_win

end
