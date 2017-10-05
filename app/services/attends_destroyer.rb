class AttendsDestroyer
  attr_accessor :id, :event_id, :current_user

  def initialize params
    params = params.symbolize_keys || {}

    @id = params[:id]

    @event_id = params[:event_id]

    @current_user = params[:current_user]
  end

  def delete
    event = current_user.own_events.find(event_id)
    event.users.delete(User.find(id))
  end
end
