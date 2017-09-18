class Session
  include ActiveModel::Validations

  attr_reader :email, :password

  def initialize params
    params = params.try(:symbolize_keys) || {}

    @user = params[:user]

    @email = params[:email]

    @password = params[:password]
  end

  validate do |model|
    if user
      model.errors.add :password, 'is invalid' unless user.authenticate password
    else
      model.errors.add :email, 'not found'
    end
  end

  def save!
    raise ActiveModel::StrictValidationFailed unless valid?

    user.auth_tokens.create
  end

  def destroy!
    user.auth_tokens.delete_all
  end

  def auth_token
    user.auth_tokens.last.value
  end

  def as_json *args
    { auth_token: auth_token }
  end

  def decorate
    self
  end

  private
  def user
    @user ||= User.find_by email: email
  end
end
