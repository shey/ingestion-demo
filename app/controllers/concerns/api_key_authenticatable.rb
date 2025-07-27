# app/controllers/concerns/api_key_authenticatable.rb
module ApiKeyAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_api_key
  end

  def authenticate_api_key
    key = request.headers['X-Api-Key'].to_s

    unless key.start_with?("alert_app")
      return render json: { error: 'Invalid key format' }, status: :unauthorized
    end

    @current_user = User.find_by(api_key: key)

    unless @current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
