class Property < ActiveRecord::Base
  belongs_to :user
  has_many :photos


  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :listing_name, presence: true
  validates :price, presence: true, numericality: { :greater_than_or_equal_to => 1 }
  validates :space_type, presence: true
  validates :category, presence: true
  validates :flatness, presence: true
  validates :dimensions, presence: true
  validates :ground_type, presence: true
  validates :charge_per, presence: true
  validates :min_time, presence: true, numericality: { :greater_than_or_equal_to => 1 }
  validates :listing_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 1500}
  validates :address, presence: true

  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end
end
