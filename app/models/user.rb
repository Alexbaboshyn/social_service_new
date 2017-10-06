class User < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :events

  has_many :invites

  has_many :own_events, class_name: 'Event', foreign_key: 'author_id'

  has_many :place_users, dependent: :destroy

  has_many :places, through: :place_users

  has_many :auth_tokens, dependent: :destroy

  enum gender: [:male, :female]

  has_attached_file :avatar, styles: { thumb: "300x300>" }

  validates_attachment :avatar, content_type: { content_type: "image/jpeg" }

  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  after_create :generate_auth_token

  acts_as_geolocated lat: 'lat', lng: 'lng'


  def distance_to_place(place)
    Place.select("places.*, earth_distance(ll_to_earth(#{place.lat}, #{place.lng}), ll_to_earth(#{self.lat}, #{self.lng})) as distance").first.distance.to_i
  end

  def generate_auth_token
    self.auth_tokens.create
  end
end
