class EventSearcher
  attr_accessor :start_date, :end_date, :range, :user

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
      events = Event.joins(:place).where('earth_box(ll_to_earth(?, ?), ?) @> ll_to_earth(places.lat, places.lng)', @user.lat, @user.lng, @range)
    end

    if @start_date.present?
      events = events.where(:start_time => @start_date..@end_date)
    end
    events
  end
end
