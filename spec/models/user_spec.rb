require 'rails_helper'

RSpec.describe User, type: :model do
  context "with 2 or more users for CSUA" do
    it "set organization members inactive" do
      A = User.create!({
        :user_name => "A",
        :user_email => "A@gmail.com",
        :is_active => true,
        :organization => "CSUA",
        :user_prime => 2,
        :admin_status => 1
      })
      B = User.create!({
        :user_name => "B",
        :user_email => "B@gmail.com",
        :is_active => true,
        :organization => "CSUA",
        :user_prime => 2,
        :admin_status => 1
      })
      User.makeInactive("CSUA")
      A.is_active.should eq(true)
      B.is_active.should eq(true)
    end
  end
  
end
