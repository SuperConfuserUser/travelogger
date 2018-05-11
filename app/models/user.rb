class User < ApplicationRecord
  has_many :trips
  validates_associated :trips

  has_secure_password
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }


  def self.find_or_create_by_omniauth(auth)
    u = find_by(uid: auth['uid'])

    if !u
      u = User.new
      u.uid = auth['uid']
      u.username = auth['info']['name']
      u.email = auth['info']['email']
      #can also bypass validations with 
      u.save(validate: false)
    end

    u
  end
end
