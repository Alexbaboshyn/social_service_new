class Api::EventsController < ApplicationController
  def build_resource
    @event = Event.new resource_params.merge(author_id: current_user.id)
  end

  def update
    resource_params.keys.each do |key|
      if key == "invites"
        resource[key] = resource[key] | resource_params[key].map(&:to_i)
      elsif key == "date"
        date = resource_params[key].split("/")
        resource.start_time = resource.start_time.change( year: date[0], month: date[1], day: date[2] )
      elsif key == "start_time"
        time = resource_params[key].split(":")
        resource.start_time = resource.start_time.change( hour: time[0], min: time[1] )
      else
        resource[key] = resource_params[key]
      end
    end
    resource.save!
  end

  private
  def resource
    @event ||= current_user.own_events.find(params[:id])
  end

  def collection
    if params[:place_id]
      @events = Event.where(place_id: params[:place_id])
    else
      @events = EventSearcher.new(params.merge(user: current_user)).search
    end
    @events
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
