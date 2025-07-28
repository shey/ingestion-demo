module Api
  class AlertsController < ApplicationController
    include ApiKeyAuthenticatable
    skip_before_action :verify_authenticity_token

    def create
      RabbitPublisher.publish(
        queue: 'alerts.ingest',
        payload: { alert: params[:alert], user_id: @current_user.id }
      )

      render json: { message: "Authorized as #{@current_user.email}" }
    end
  end
end
