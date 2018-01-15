class ApplicationController < ActionController::API
  class Unauthorized < StandardError; end

  unless Rails.env.development?
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from Unauthorized, with: :render_unauthorized
  end

  attr_reader :current_user

  def authenticate!
    token = request.headers["HTTP_AUTHORIZATION"].presence || params[:token]
    raise Unauthorized unless token
    token = token.split(/\s+/).last
    @current_user = User.find_by_access_token(token)

    raise Unauthorized unless current_user
  end

  def authenticate_from_google!
    token = request.headers["HTTP_AUTHORIZATION"].presence || params[:token]
    raise Unauthorized unless token
    token = token.split(/\s+/).last
    client_id = $sesames["google_signin"]["client_id"][Rails.env]
    validator = GoogleIDToken::Validator.new
    response = validator.check(token, client_id)
    attributes = {}
    if params[:signup_category].present?
      attributes[:signup_category] = params[:signup_category]
    end
    @current_user = User.find_or_create_from_google(response, attributes)
  rescue GoogleIDToken::ValidationError => e
    Rollbar.error(e)
    raise Unauthorized
  end

  def render_not_found
    render json: { error: 'Not Found' }, status: 404
  end

  def render_unauthorized
    render json: { error: 'Not Authorized' }, status: 401
  end
end
