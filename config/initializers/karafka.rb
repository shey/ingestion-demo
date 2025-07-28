# config/karafka.rb
class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka.seed_brokers = ['kafka://localhost:9092']
    config.client_id = 'my_app'
  end

  routes.draw do
    topic 'alerts.ingest' do
      consumer AlertWorker
    end
  end
end
