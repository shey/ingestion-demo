module Api
  class AlertsController < ApplicationController
    include ApiKeyAuthenticatable
    skip_before_action :verify_authenticity_token

    def create
      message_id = SecureRandom.uuid7

      KafkaProducer.publish(
        topic: 'alerts.ingest',
        payload: {
          id: message_id,
          alert: params[:alert],
          user_id: @current_user.id,
          received_at: Time.current.utc.iso8601
        }
      )

      render json: { message: "Accepted alert #{@current_user.email}", id: message_id }, status: :accepted
    end
  end
end
