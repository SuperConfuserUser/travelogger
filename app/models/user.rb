class User < ApplicationRecord
  has_many :trips
  validates_associated :trips

  has_secure_password
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, allow_blank: true, uniqueness: { case_sensitive: false }
end
