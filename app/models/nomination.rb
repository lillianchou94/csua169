class Nomination < ActiveRecord::Base
    self.table_name = "nominations"
    # belongs_to :users
    attr_accessible :users_id, :election_id, :organization, :user_id, :threshold, :position, :num_seconds, :prime_product
    
end
