require 'aws-sdk'
require 'byebug'
require './ec2'

ec2 =  Aws::EC2::Resource.new(region: 'ap-southeast-1')
client = EC2.new(ec2)
client.create_instance