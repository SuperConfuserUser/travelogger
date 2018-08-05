class UserSerializer < ActiveModel::Serializer
  has_many :trips
  has_many :locations

  attributes :id, :username, :email, :image, :tagline, :profile
end
