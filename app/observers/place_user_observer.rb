class PlaceUserObserver < ActiveRecord::Observer
  def after_create(place_user)
    @place_user = place_user

    Place.find_by(id: @place_user.place_id).update_attribute(:overall_rating, rating)
  end

  def rating
    PlaceUser.where(place_id: @place_user.place_id).average(:rating)
  end
end
