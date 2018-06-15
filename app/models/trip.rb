class Trip < ApplicationRecord
  belongs_to :user
  has_many :trip_categories
  has_many :categories, through: :trip_categories
  has_many :entries
  has_many :locations, as: :place

  accepts_nested_attributes_for :locations, :allow_destroy => true 

  validates :name, presence: true
  validate :has_location?
  validates :start_date, presence: true
  validate :end_date_not_before_start_date
  validate :has_category?

  # Use this instead of "reject_if: proc {|attributes| attributes['name'].blank?}" or "reject_if: :all_blank" to be able to create multiple blank fields for form input. Otherwise, user has to fill field, then add one by one
  before_save :reject_blank_locations!
  
  def has_location?
    named_locations = locations.count { |location| location.name.present? }
    if named_locations == 0
      errors.add(:locations, "can't be blank")
    end
  end

  def reject_blank_locations!
    locations.each do |location|
      location.destroy if location.name.blank?
    end
  end

  def end_date_not_before_start_date
    if start_date.present? && end_date.present? && start_date > end_date
      errors.add(:end_date, "can't be before the start date")
    end
  end

  def has_category?
    if category_ids.none? # if it's only the hidden field
      errors.add(:categories, "need to be chosen")
    end
  end

end
