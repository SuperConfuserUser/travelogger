class Entry < ApplicationRecord
  belongs_to :trip
  has_many :locations, as: :place
end
