class Trip < ApplicationRecord
  belongs_to :user
  has_many :trip_categories
  has_many :categories, through: :trip_categories
  has_many :entries
  has_many :locations, as: :place
  validates_associated :locations
  accepts_nested_attributes_for :locations, :allow_destroy => true, reject_if: proc {|attributes| attributes['name'].blank?}

  validates :name, presence: true
  validate :has_a_location
  validates :start_date, presence: true
  validate :end_date_not_before_start_date
  validate :has_a_category

  
  def has_a_location
    if locations.none?
      errors.add(:locations, "can't be blank")
    end
  end

  def end_date_not_before_start_date
    if start_date.present? && end_date.present? && start_date > end_date
      errors.add(:end_date, "can't be before the start date")
    end
  end

  def category_ids=(ids)
    ids.each do |id|
      category = Category.find(id)
      self.categories << category
    end
  end

  def has_a_category
    if category_ids.none?
      errors.add(:categories, "need to be chosen")
    end
  end

end
