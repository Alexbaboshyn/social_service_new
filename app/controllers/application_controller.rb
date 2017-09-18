class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token

  helper_method :collection, :resource, :current_user

  before_action :authenticate

  attr_reader :current_user

  rescue_from ActiveRecord::RecordNotFound do |exception|
    @exception = exception

    head 404
  end

  rescue_from ActiveRecord::RecordInvalid, ActiveModel::StrictValidationFailed do
    render :errors, status: :unprocessable_entity
  end

  def create
    build_resource

    resource.save!
  end

  def update
    resource.update! resource_params
  end

  def destroy
    resource.destroy!

    head 204
  end

  def current_user
    @current_user
  end

  private
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      # @current_user = User.joins(:auth_tokens).find_by(auth_tokens: { value: token, expired_at: DateTime.now..(DateTime.now + 2.weeks) })
      @current_user = User.joins(:auth_tokens).find_by(auth_tokens: { value: token })
    end
  end
end
