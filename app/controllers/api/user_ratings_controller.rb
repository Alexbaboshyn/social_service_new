class Api::UserRatingsController < ApplicationController
  helper_method :context

  private
  def context
    @context
  end

  def collection
    if params[:user_id].present?
      @context = {user: true}
      @collection = PlaceUser.where(user_id: params[:user_id])
    elsif params[:place_id].present?
      @context = {place: true}
      @collection = Place.find (params[:place_id])
    end
    @collection
  end
end
