class Api::ProfilesController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def build_resource
    @user = User.new resource_params
  end

  private
  def resource
    @user ||= current_user
  end

  def resource_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :gender,
                                 :birthday,
                                 :lat,
                                 :lng,
                                 :avatar)
  end
end
