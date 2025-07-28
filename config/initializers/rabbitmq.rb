# config/initializers/rabbitmq.rb
require 'bunny'
require 'connection_pool'

class RabbitMQ
  def self.pool
    @pool ||= ConnectionPool.new(size: 5, timeout: 5) do
      Bunny.new(
        hostname: ENV.fetch('RABBITMQ_HOST', 'localhost'),
        username: ENV.fetch('RABBITMQ_USER', 'kalo'),
        password: ENV.fetch('RABBITMQ_PASS', 'kalo')
      ).tap(&:start)
    end
  end

  def self.with_connection(&block)
    pool.with(&block)
  end
end

class RabbitPublisher
  def self.publish(queue:, payload:)
    RabbitMQ.with_connection do |conn|
      publish_and_close(conn, queue, payload)
    end
  end

  def self.publish_and_close(conn, queue, payload)
    channel = conn.create_channel
    begin
      q = channel.queue(queue, durable: true)
      q.publish(payload.to_json, persistent: true, content_type: 'application/json')
    ensure
      channel.close
    end
  end
end
