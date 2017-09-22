class EventSearcher

  attr_accessor :city, :range, :tags, :current_user

  def initialize params
    params = params.symbolize_keys || {}

    @start_date = params[:start_date]

    @end_date = params[:end_date]

    @range = params[:range]

    @user = params[:user]
  end

  def search
    events = Event.all

    if @range.present?
      events = Place.within_radius(@range, @user.lat, @user.lng).all.map { |place| place.events }
    end

    if @start_date.present?
      events = Event.where(:start_time => @start_date..@end_date)
    end
    events
  end
end
