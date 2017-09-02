class Room < ApplicationRecord
  enum instant: {Request: 0, Instant: 1}
  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :guest_reviews

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bed_room, presence: true
  validates :bath_room, presence: true

  scope :search_from_location, ->(location=nil){
    if location.blank?
      where(active: true).all
    else
      where(active: true).near(location, 5, order: 'distance')
    end
  }

  def average_rating
    guest_reviews.count == 0 ? 0 : guest_reviews.average(:star).round(2).to_i
  end
end
