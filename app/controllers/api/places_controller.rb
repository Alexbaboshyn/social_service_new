class Api::PlacesController < ApplicationController
  private
  def resource
    place = Place.find_by(id: params[:id])

    if place == nil
      place = Place.find_by(city: params[:id])

      if place == nil
        place = PlaceBuilder.new(params[:id]).build
      end
    end
    place
  end

  def collection
    @places = PlaceSearcher.new(params.merge(current_user: current_user))
                           .search.order_by_distance(current_user.lat, current_user.lng)
  end
end
