class AlertWorker
   def consume
     messages.each do |message|
       payload = message.payload
       Alert.create!(
         message: payload['message'],
         received_at: Time.current,
         raw_payload: payload
       )
     end
   end
end
