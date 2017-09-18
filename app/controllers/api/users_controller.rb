class Api::UsersController < ApplicationController
  private
  def resource
    User.find(params[:id])
  end

  def collection
    User.all
  end
end
