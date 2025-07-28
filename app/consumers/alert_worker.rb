class AlertWorker < ApplicationConsumer
  def consume
    messages.each do |message|
      payload = message.payload

      alert = Alert.create!(
        message: payload['message'],
        received_at: Time.current,
        raw_payload: payload
      )

      Turbo::StreamsChannel.broadcast_prepend_to(
        "alerts_stream",
        target: "alerts",
        partial: "alerts/alert",
        locals: { alert: alert }
      )
    end
  end
end
