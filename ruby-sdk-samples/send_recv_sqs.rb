require 'aws-sdk'
require 'byebug'
require './sqs'

sqs = Aws::SQS::Client.new({region: 'ap-southeast-1'})
sqsClient = SQS.new sqs
puts sqsClient.queue_exists? "JournalEntries2"