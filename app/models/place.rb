class Place < ApplicationRecord
  has_many :place_users

  has_many :events, dependent: :destroy

  has_many :users, through: :place_users

  acts_as_geolocated lat: 'lat', lng: 'lng'
end
