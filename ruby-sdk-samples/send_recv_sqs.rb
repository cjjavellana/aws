require 'aws-sdk'
require 'byebug'
require './sqs'

def receive_message(client, queue_url)
  while true
    puts "Checking if message has arrived"
    msgs = client.receive_message queue_url#, {wait_time_seconds: 20}
    unless msgs.messages.empty?
      msgs.messages.each do |msg|
        puts "Receipt Handle: #{msg.receipt_handle}; Message Content: #{msg.body}"
        client.delete_message(queue_url, msg.receipt_handle)
      end
      break
    end
  end
end

sample_queue =  "my-sample-queue"

sqs = Aws::SQS::Client.new({region: 'ap-southeast-1'})
sqsClient = SQS.new sqs

sample_queue_exists = sqsClient.queue_exists? sample_queue
puts "Checking if my-sample-queue exists: #{sample_queue_exists}"
sqsClient.create_queue(sample_queue) unless sample_queue_exists

queue_url = sqsClient.get_queue_url sample_queue
t1 = Thread.new {
  receive_message(sqsClient, queue_url)
}

# Wait for 5 sec before sending the message
sleep 5

# Send the message, causing the listener thread to terminate
sqsClient.send_message(queue_url, "This is the message body")

# Wait for listener thread to finish before we complete too
t1.join