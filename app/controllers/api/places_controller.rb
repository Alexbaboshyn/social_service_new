class Api::PlacesController < ApplicationController
  private
  def resource
    Place.find(params[:id])
  end

  def collection
    @places = PlaceSearcher.new(params.merge(current_user: current_user))
                           .search.order_by_distance(current_user.lat, current_user.lng)
  end
end
