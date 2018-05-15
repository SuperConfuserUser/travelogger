class User < ApplicationRecord
  has_many :trips
  validates_associated :trips

  has_secure_password
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }


  def self.find_or_create_by_omniauth(auth_hash)
    user = User.find_or_create_by(uid: auth_hash[:uid]) do |u|
        u.username =  auth_hash[:info][:name]
        u.email =  auth_hash[:info][:email]
        u.password =  SecureRandom.hex
    end

    # user = User.find_by(uid: auth_hash['uid'])

    # if !user
    #   user = User.new
    #   user.uid = auth['uid']
    #   user.username = auth['info']['name']
    #   user.email = auth['info']['email']
    #   #can also bypass validations with 
    #   user.save(validate: false)
    # end
    
    return user
  end

  def self.login(user_hash)
    user = User.find_or_create_by(email: user_hash[:email])
   
    auth = user.authenticate(user_hash[:password]) if user.valid? 
    user.password = user_hash[:password] if !auth

    user.errors.add(:email, "didn't match any existing accounts") if user.invalid? && user_hash[:email].present?
    user.errors.add(:password, "didn't match") if !auth && user_hash[:password].present?
    user.errors.add(:password, "can't be blank") if !user.errors[:password].any? && !user_hash[:password].present?
    user.errors[:username].clear

    return user
  end

  # def alerts
  #   @alerts ||= self.errors.full_messages
  # end

end
