require 'aws-sdk'
require 'byebug'
require './sqs'

sqs = Aws::SQS::Client.new({region: 'ap-southeast-1'})
sqsClient = SQS.new sqs

sample_queue_exists = sqsClient.queue_exists? "my-sample-queue"
puts "Checking if my-sample-queue exists: #{sample_queue_exists}"
sqsClient.create_queue("my-sample-queue") unless sample_queue_exists
