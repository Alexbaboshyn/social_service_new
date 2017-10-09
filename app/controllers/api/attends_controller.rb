class Api::AttendsController < ApplicationController
  def create
    parent.users << current_user

    head :ok
  end

  def destroy
    AttendsDestroyer.new(params.merge(current_user: current_user)).delete    
  end

  private
  def parent
    Event.find(params[:event_id])
  end
end
