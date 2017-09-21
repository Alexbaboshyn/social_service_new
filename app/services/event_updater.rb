class EventUpdater
  attr_accessor :resource, :params

  def initialize params
    @params = params || {}

    @resource = params[:resource]
  end

  def update
    @params.delete(:resource)

    @params.keys.each do |key|
      if key == "invites"
        @resource[key] = @resource[key] | @params[key].map(&:to_i)
      elsif key == "date"
        date = @params[key].split("/")
        @resource.start_time = @resource.start_time.change( year: date[0], month: date[1], day: date[2] )
      elsif key == "start_time"
        time = @params[key].split(":")
        @resource.start_time = @resource.start_time.change( hour: time[0], min: time[1] )
      else
        @resource[key] = @params[key]
      end
    end
    @resource
  end

end
