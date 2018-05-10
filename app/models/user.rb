class User < ApplicationRecord
  has_many :trips

  has_secure_password
end
