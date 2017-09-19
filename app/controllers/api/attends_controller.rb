class Api::AttendsController < ApplicationController
  def create
    parent.users << current_user

    head :ok
  end

  def destroy
    parent.users.delete(User.find(params[:id]))
  end


  private
  def parent
    Event.find(params[:event_id])
  end
end
