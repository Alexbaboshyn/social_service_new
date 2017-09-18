class Api::PlaceUsersController < ApplicationController
  def build_resource
    @place_user = parent.place_users.build (resource_params.merge(user: current_user))
  end

  private
  def resource
    @place_user
  end

  def parent
    @parent ||= Place.find(params[:place_id])
  end

  def resource_params
    params.require(:place_user).permit(:rating)
  end
end
