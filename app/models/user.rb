class User < ActiveRecord::Base
    has_many :elections
    attr_accessor :user_id, :csua, :hkn
    
end