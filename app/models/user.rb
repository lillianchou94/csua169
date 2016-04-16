class User < ActiveRecord::Base
  #self.table_name = "users"
  # has_many :elections
  # has_many :nominations
  attr_accessible :user_name, :is_active, :provider, :uid, :oauth_token, :oauth_expires_at, :user_email, :organization, :admin_status, :user_prime, :votes, :has_voted
  validates :user_name, presence: true
  validates :user_email, presence: true
  validates :organization, presence: true
  validates :user_prime, presence: true
  validates :admin_status, presence: true
  
  #return the next prime
  def getPrime()
    max = User.maximum(:user_prime)
    prime = Prime.take_while {|p| p < max}
    newpri = Prime.first prime.count+2
    return newpri[prime.count+1]
  end

  def self.makeInactive(organization)
    org_user = User.where(:organization => organization)
    org_user.each do |user|
      user.update_attribute(:is_active, false)
    end
  end

  #make all user of the org inactive first, then reactivate them or create new
  def self.import(file, org, admin_status)
    self.makeInactive(org)
    CSV.parse(File.read(file)).each do |row|
      user = User.where(:user_name => row[0], :user_email => row[1], :organization => org, :admin_status => admin_status)
      if user.count > 1
        user.update_all(:is_active => true)
      elsif user.count == 1
        user.update_all(:is_active => true)
      else
        User.create!(:user_name => row[0], :user_email => row[1], :organization => org, :is_active => true, :admin_status => admin_status, :user_prime => self.getPrime())
      end 
    end
  end 
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
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

