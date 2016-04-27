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
  
  def before_import_save(record)
    self.user_prime = User.getPrime()  
  end
  
  def getAdminStatus()
    all_same_user = User.where(user_email: self.user_email)
    my_org_adminstatus_pair = Hash.new
    for user in all_same_user
      my_org_adminstatus_pair.store(user.organization, user.admin_status)
    end
    return my_org_adminstatus_pair
  end
  
  def has_non_zero_prime?
    all_same_user = User.where(user_email: self.user_email)
    for user in all_same_user
      if user.user_prime != 0
        return true
      end
    end
    return false
  end
  
  def is_in_org(organization)
    h = self.getAdminStatus()
    return h.has_key?(organization)
  end
  
  def is_admin_at_all?
    h = self.getAdminStatus()
    for org in h.keys
      if h[org] == 1
        return true
      end
    end
    return false
  end
  
  def is_super_admin?
    h = self.getAdminStatus()
    for org in h.keys
      if h[org] == 2
        return true
      end
    end
    return false
  end
  
  #return the next prime
  def self.getPrime()
    max = User.maximum(:user_prime)
    prime = Prime.take_while {|p| p < max}
    newpri = Prime.first prime.count+2
    return newpri[prime.count+1]
  end
  
  def self.from_omniauth(auth)
    User.where(user_email: auth.info.email).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.user_name = auth.info.name
      user.user_email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.user_prime = (user.user_prime != nil ? user.user_prime : 0)
      user.organization = (user.organization != nil ? user.organization : 'NA')
      user.admin_status = (user.admin_status != nil ? user.admin_status : 0)
      user.is_active = true
      user.save!
    end
  end
end

