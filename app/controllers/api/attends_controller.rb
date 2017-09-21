class Api::AttendsController < ApplicationController
  def create
    parent.users << current_user

    head :ok
  end

  def destroy
    event = current_user.own_events.find(params[:event_id])
    event.users.delete(User.find(params[:id]))
  end

  private
  def parent
    Event.find(params[:event_id])
  end
end
