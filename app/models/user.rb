class User < ActiveRecord::Base
  require 'csv'
  require 'prime'
  self.table_name = "users"
  # has_many :elections
  # has_many :nominations
  attr_accessible :user_name, :provider, :uid, :oauth_token, :oauth_expires_at, :user_email, :organization, :admin_status, :user_prime, :votes

  def self.makeInactive(organization)
    org_user = User.where(organization: organization)
    org_user.each do |user|
      user.update_attributes(:is_active, false)
    end
  end

  #make all user of the org inactive first, then reactivate them or create new
  def self.import(file, organization)
    self.makeInactive(organization)
    CSV.foreach(file.path, headers: true) do |row|
      user_hash = row.to_hash
      user = user.where(user_name: user_hash["name"], user_email: user_hash["user_email"], organization: organization)

      if user.count == 1
        user.first.update_attributes(is_active: true)
      else
        User.create!(user_name: user_hash["name"], user_email: user_hash["user_email"], organization: organization, is_active: true)
      end 
    end
  end 

  def self.from_omniauth(auth)
    puts "auth is #{auth}"
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      # if user.nil?
      #   user = User.create(:user_name => 'Fake User 1')
      # end
      
      user.provider = auth.provider
      user.uid = auth.uid
      user.user_name = auth.info.name
      user.user_email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end

