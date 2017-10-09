class Api::EventsController < ApplicationController
  def build_resource
    @event = Event.new(resource_params.merge(author_id: current_user.id))
  end

  def update
    event = EventUpdater.new(resource_params.merge(resource: resource)).update

    event.save!
  end

  private
  def resource
    @event ||= current_user.own_events.find(params[:id])
  end

  def collection
    if params[:place_id]
      Event.where(place_id: params[:place_id])
    else
      EventSearcher.new(params.merge(user: current_user)).search
    end  
  end

  def resource_params
    params.require(:event).permit(:place_id,
                                  :kind,
                                  :start_time,
                                  :date,
                                  :title,
                                  invites: []
                                  )
  end
end
