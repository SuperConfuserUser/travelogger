class User < ApplicationRecord
  has_many :trips
  validates_associated :trips

  has_secure_password
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  before_save :default_values

  def default_values
    self.image ||= "default_profile.png"
  end

  def self.find_or_create_by_omniauth(auth_hash)
    user = self.where(uid: auth_hash[:uid]).first_or_create do |u|
      u.username =  auth_hash[:info][:name]
      u.email =  auth_hash[:info][:email]
      u.image = auth_hash[:info][:image]
      u.password =  SecureRandom.hex
    end

    user.errors.add(:base, "Something went wrong with using your Facebook account") if user.invalid?
    
    return user
  end

  def self.login(user_hash)
    user = User.find_or_create_by(email: user_hash[:email])
   
    auth = user.authenticate(user_hash[:password]) if user.valid? 
    user.password = user_hash[:password] if !auth

    user.errors.add(:email, "didn't match any existing accounts") if user.invalid? && user_hash[:email].present?
    user.errors.add(:password, "didn't match for this email") if !auth && user_hash[:password].present?
    user.errors.add(:password, "can't be blank") if !user.errors[:password].any? && !user_hash[:password].present?
    user.errors[:username].clear

    return user
  end

end
