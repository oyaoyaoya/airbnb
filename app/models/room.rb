class Room < ApplicationRecord
  belongs_to :user
  has_many :photos

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :home_type, presents: true
  validates :room_type, presents: true
  validates :accomodate, presents: true
  validates :bed_room, presents: true
  validates :bath_room, presents: true
  validates :listing_name, presents: true, length: {maximum: 50}
  validates :summary, presents: true, length: {maximum: 500}
  validates :address, presents: true
end
