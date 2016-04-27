require 'rails_helper'
require 'prime'

RSpec.describe User, type: :model do
  context "testing is_admin_at_all? with 2 users one is admin one is not" do 
    it "should return true if a user is an admin for any org" do
      A = User.create!({
        :user_name => "A",
        :user_email => "A@gmail.com",
        :is_active => true,
        :organization => "CSUA",
        :user_prime => 2,
        :admin_status => 1
      })
      User.create!({
        :user_name => "A",
        :user_email => "A@gmail.com",
        :is_active => true,
        :organization => "HKN",
        :user_prime => 2,
        :admin_status => 0
      })
      B = User.create!({
        :user_name => "B",
        :user_email => "B@gmail.com",
        :is_active => true,
        :organization => "CSUA",
        :user_prime => 2,
        :admin_status => 0
      })
      
      A.is_admin_at_all?.should eq(true)
      B.is_admin_at_all?.should eq(false)
    end
  end

  context "testing is_super_admin? with 3 users one is super admin, one is admin, one is member" do 
    it "should return true if a user is an super admin for any org" do
      C = User.create!({
        :user_name => "C",
        :user_email => "C@gmail.com",
        :is_active => true,
        :organization => "CSUA",
        :user_prime => 2,
        :admin_status => 2
      })
      D = User.create!({
        :user_name => "D",
        :user_email => "D@gmail.com",
        :is_active => true,
        :organization => "HKN",
        :user_prime => 3,
        :admin_status => 1
      })
      E = User.create!({
        :user_name => "E",
        :user_email => "E@gmail.com",
        :is_active => true,
        :organization => "CSUA",
        :user_prime => 5,
        :admin_status => 0
      })
      
      C.is_super_admin?.should eq(true)
      D.is_super_admin?.should eq(false)
      E.is_super_admin?.should eq(false)
    end
  end

  context "testing is_in_org(organization) with 2 users one is in org one is not" do 
    it "should return true if a user is an admin for any org" do
      F = User.create!({
        :user_name => "F",
        :user_email => "F@gmail.com",
        :is_active => true,
        :organization => "CSUA",
        :user_prime => 2,
        :admin_status => 1
      })
      User.create!({
        :user_name => "F",
        :user_email => "F@gmail.com",
        :is_active => true,
        :organization => "HKN",
        :user_prime => 2,
        :admin_status => 0
      })
      G = User.create!({
        :user_name => "G",
        :user_email => "G@gmail.com",
        :is_active => true,
        :organization => "CSUA",
        :user_prime => 2,
        :admin_status => 0
      })
      
      F.is_in_org("HKN").should eq(true)
      F.is_in_org("CSUA").should eq(true)
      G.is_in_org("HKN").should eq(false)
      G.is_in_org("CSUA").should eq(true)
    end
  end
  
    context "testing has_non_zero_prime? with 2 users one has non-zero prime, one has zero prime" do 
    it "should return true if a user has a non zero prime" do
      H = User.create!({
        :user_name => "H",
        :user_email => "H@gmail.com",
        :is_active => true,
        :organization => "CSUA",
        :user_prime => 0,
        :admin_status => 1
      })
      User.create!({
        :user_name => "H",
        :user_email => "H@gmail.com",
        :is_active => true,
        :organization => "CSUA",
        :user_prime => 2,
        :admin_status => 2
      })
      I = User.create!({
        :user_name => "I",
        :user_email => "I@gmail.com",
        :is_active => true,
        :organization => "CSUA",
        :user_prime => 0,
        :admin_status => 0
      })
      
      H.has_non_zero_prime?.should eq(true)
      I.has_non_zero_prime?.should eq(false)
    end
  end
  
  context "testing getAdminStatus() with 1 user who is admin for HKN and not CSUA" do 
    it "should return true if a user is an admin for any org" do
      J = User.create!({
        :user_name => "J",
        :user_email => "J@gmail.com",
        :is_active => true,
        :organization => "CSUA",
        :user_prime => 2,
        :admin_status => 1
      })
      User.create!({
        :user_name => "J",
        :user_email => "J@gmail.com",
        :is_active => true,
        :organization => "HKN",
        :user_prime => 2,
        :admin_status => 0
      })
      h = Hash.new
      h["CSUA"] = 1
      h["HKN"] = 0
      J.getAdminStatus().should eq(h)
    end
  end
  
  context "testing getPrime" do
    it "should return the prime that is after the max of all user_prime" do
      K = User.create!({
        :user_name => "K",
        :user_email => "K@gmail.com",
        :is_active => true,
        :organization => "CSUA",
        :user_prime => 2,
        :admin_status => 1
      })
      
      max = User.maximum(:user_prime)
      prime = Prime.take_while {|p| p < max}
      newpri = Prime.first prime.count+2
      nextp = newpri[prime.count+1]
      User.getPrime().should eq(nextp)
    end
  end
  
  describe User do
  it "fails validation with no name" do
    User.new.should_not be_valid
  end

  it "fails validation with a name" do
    User.new(:user_name => "user one").should_not be_valid
  end
  
  it "fails validation with a name and email" do
    User.new(:user_name => "user one", :user_email => "userone@gmail.com").should_not be_valid
  end
  
  it "fails validation with a name, email, and org" do
    User.new(:user_name => "user one", :user_email => "userone@gmail.com", :organization => "CSUA").should_not be_valid
  end
  
  it "fails validation with a name, email, org, and prime" do
    User.new(:user_name => "user one", :user_email => "userone@gmail.com", :organization => "CSUA", :user_prime => 1).should_not be_valid
  end
  
  it "passes validation with a name, email, org, prime, and admin_status" do
    User.new(:user_name => "user one", :user_email => "userone@gmail.com", :organization => "CSUA", :user_prime => 1, :admin_status => 0).should be_valid
  end

end
  
end
