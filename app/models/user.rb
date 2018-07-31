class User < ApplicationRecord
  has_many :trips
  has_many :locations, through: :trips
  validates_associated :trips

  has_secure_password
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  before_save :default_values

  # INITIALIZATIONS AND VALIDATIONS

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

    user.errors.add(:base, "Login did not work") if user.invalid?
    
    return user
  end

  def self.login(user_hash)
    user = User.find_or_create_by(email: user_hash[:email])
    auth = user.authenticate(user_hash[:password]) if user.valid? 

    if !user.valid? || !auth 
      user.errors.clear
      user.errors.add(:base, "Login did not work")
    end

    return user
  end

  # CUSTOM

  
end
