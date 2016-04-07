class User < ActiveRecord::Base
  self.table_name = "users"
  # has_many :elections
  # has_many :nominations
  attr_accessible :user_name, :provider, :uid, :oauth_token, :oauth_expires_at, :user_email, :organization, :admin_status, :user_prime, :votes

  def self.from_omniauth(auth)
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

