class UsersController < ApplicationController
  def auth
    if params[:provider] == "google"
      authenticate_from_google!
    elsif params[:provider] == "pb"
      authenticate!
    else
      raise Unauthorized
    end

    render json: {
      user: UserSerializer.new(current_user).as_json,
      access_token: current_user.access_token,
    }
  end
end
