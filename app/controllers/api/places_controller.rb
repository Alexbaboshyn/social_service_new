class Api::PlacesController < ApplicationController
  private
  def resource
    place = PlaceSearcher.new(params.merge(current_user: current_user)).search_by_id

    place = PlaceBuilder.new(params[:id]).build if place.empty?

    place
  end

  def collection
    @places = PlaceSearcher.new(params.merge(current_user: current_user))
                           .search.order_by_distance(current_user.lat, current_user.lng)
  end
end
