class Trip < ApplicationRecord
  belongs_to :user
  has_many :trip_categories
  has_many :purposes, through: :trip_categories
  has_many :entries
  has_many :locations, as: :place
  accepts_nested_attributes_for :locations, :allow_destroy => true, reject_if: proc {|attributes| attributes['name'].blank?}
end
