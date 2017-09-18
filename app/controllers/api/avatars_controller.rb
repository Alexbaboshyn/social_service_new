class Api::AvatarsController < ApplicationController
  def create
    current_user.update! resource_params

    head :ok
  end

  def destroy
    current_user.avatar = nil

    current_user.save

    head 204
  end

  private
  def resource_params
    params.require(:user).permit(:avatar)
  end
end
