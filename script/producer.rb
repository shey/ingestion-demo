# scripts/pump_alerts.rb
require 'bunny'
require 'json'

conn = Bunny.new(hostname: 'localhost', username: 'kalo', password: 'kalo')
conn.start

ch = conn.create_channel
q  = ch.queue('default', durable: true)

count = 0
start = Time.now

loop do
  payload = { message: "Alert ##{count}" }.to_json
  q.publish(payload, persistent: false)

  count += 1
  if Time.now - start > 1
    puts "Published #{count} messages in the last second"
    count = 0
    start = Time.now
  end
end
