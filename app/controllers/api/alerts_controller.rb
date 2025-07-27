module Api
  class AlertsController < ApplicationController
    include ApiKeyAuthenticatable
    skip_before_action :verify_authenticity_token

    def create
      render json: { message: "Authorized as #{@current_user.email}" }
    end
  end
end
