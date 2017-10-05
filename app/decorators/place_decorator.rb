class PlaceDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user

  private
  def _only
    if context[:short]
      %i[id name city]
    else
      %i[id name place_id tags city overall_rating]
    end
  end


  def _methods
    if context[:short]
      %i[distance]
    elsif context[:place]
      %i[coords distance ratings]
    else
      %i[coords distance]
    end  
  end

  def coords
    {
      lat: lat,

      lng: lng
    }
  end

  def distance
    h.current_user.distance_to_place(model)
  end

  def ratings
    place_users.map do |place_user|
      { user: place_user.user.decorate(context: { brief: true }), rating: place_user.rating }
    end
  end
end
