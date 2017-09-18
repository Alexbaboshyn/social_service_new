class EventSearcher

  attr_accessor :city, :range, :tags, :current_user

  def initialize params
    params = params.symbolize_keys || {}

    @date = params[:date]

    @range = params[:range]

    @user = params[:user]
  end

  def search
    events = Event.all

    if @range.present?
      events = Place.within_radius(@range, @user.lat, @user.lng).all.map { |place| place.events }
      byebug
    end
    events
  end
end
