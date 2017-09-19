class EventDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user

  decorates_association :place

  private
  def _only
    %I[id kind title]
  end

  def _methods
    methods = %I[place date time author people_attended_count people_attended invited]
  end

  def place
    Place.find(place_id).decorate(context: { short: true })
  end

  def date
    start_time.to_date
  end

  def time
    start_time.strftime("%H:%M")
  end

  def author
    User.find(author_id).decorate(context: { brief: true })
  end

  def people_attended_count
    users.count
  end

  def invited
    invites.map { |id| User.find(id).decorate(context: { brief: true }) }
  end

  def people_attended
    users.decorate(context: { brief: true })
  end
end
