class AlertWorker
  include Sneakers::Worker
  from_queue 'default',
    durable: true,
    prefetch: 50

  BATCH_SIZE = 50

  def work(raw_msg)
    buffer = Thread.current[:alert_buffer] ||= []

    data = JSON.parse(raw_msg)
    buffer << {
      message: data['message'] || 'unknown',
      received_at: Time.current
    }

    if buffer.size >= BATCH_SIZE
      Alert.insert_all(buffer)
      Sneakers.logger.info("Inserted #{buffer.size} alerts (thread #{Thread.current.object_id})")
      buffer.clear
    end

    ack!
  rescue => e
    Sneakers.logger.error("Worker error: #{e.message}")
    reject!
  end
end
