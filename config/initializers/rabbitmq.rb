# config/initializers/rabbitmq.rb
require 'bunny'
require 'connection_pool'

# todo: make the timeout and size configurable via ENV variables
$rabbitmq_pool = ConnectionPool.new(size: 5, timeout: 5) do
  conn = Bunny.new(hostname: 'localhost', username: 'kalo', password: 'kalo').tap(&:start)
  conn
end
