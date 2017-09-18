class User < ApplicationRecord
  has_secure_password

  has_many :place_users, dependent: :destroy

  has_many :places, through: :place_users

  has_and_belongs_to_many :events

  enum gender: [:male, :female]

  has_many :auth_tokens, dependent: :destroy

  has_attached_file :avatar, styles: { thumb: "300x300>" }

  validates_attachment :avatar,
                        content_type: { content_type: "image/jpeg" }


  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  after_create :generate_auth_token

  acts_as_geolocated lat: 'lat', lng: 'lng'


  def distance_to_place(lat, lon)
    rad_per_deg = Math::PI / 180
    rm = 6371000

    lat1_rad, lat2_rad = lat * rad_per_deg, self.lat * rad_per_deg
    lon1_rad, lon2_rad = lon * rad_per_deg, self.lng * rad_per_deg

    a = Math.sin((lat2_rad - lat1_rad) / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin((lon2_rad - lon1_rad) / 2) ** 2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))

    (rm * c).to_i
  end

  def generate_auth_token
    self.auth_tokens.create
  end

  def own_events
    Event.where(author_id: self.id)
  end
end
