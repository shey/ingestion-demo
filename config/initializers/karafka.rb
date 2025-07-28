Karafka::App.setup do |config|
  config.kafka = {
    'bootstrap.servers': ENV.fetch('KAFKA_URL', 'localhost:9092')
  }
  config.client_id = 'your_app_kafka_client'
end
