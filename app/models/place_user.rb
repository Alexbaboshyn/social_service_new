class PlaceUser < ApplicationRecord
  belongs_to :user

  belongs_to :place

  validates :user_id, uniqueness: { scope: :place_id }

  validates :rating, inclusion: { in: 1..5 }
end
