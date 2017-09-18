class AuthTokenDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    { value: value, expired_at: expired_at }
  end
end
