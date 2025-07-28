module ApiKeyAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_api_key
    attr_reader :current_user
  end

  private

  def authenticate_api_key
    key = request.headers["X-Api-Key"].to_s

    return unauthorized!("missing or malformed") unless key.start_with?("alert_app")

    user_id = Rails.cache.fetch("auth:api_key:#{key}", expires_in: 10.minutes) do
      User.find_by(api_key: key)&.id
    end

    @current_user = User.find_by(id: user_id)

    unauthorized!("invalid") unless @current_user
  end

  def unauthorized!(msg)
    render json: { error: "Unauthorized (#{msg})" }, status: :unauthorized
  end
end
