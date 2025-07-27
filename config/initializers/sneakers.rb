require 'sneakers'
require 'sneakers/worker'

Sneakers.configure(
  amqp: 'amqp://kalo:kalo@localhost:5672',
  vhost: '/',
  exchange: '',
  exchange_type: :direct,
  workers: 1,
  durable: true,
  ack: true,
  log: STDOUT,
  threads: 4
)

Sneakers.logger.level = Logger::INFO
