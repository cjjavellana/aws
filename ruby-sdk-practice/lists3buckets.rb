require 'aws-sdk'
require 'byebug'

#Aws.config.update({
#    region: 'ap-southeast-1',
#    credentials: Aws::AssumeRoleCredentials.new
#})

s3 = Aws::S3::Client.new({
	region: 'ap-southeast-1',
	credentials: Aws::InstanceProfileCredentials.new
})
resp = s3.list_buckets
print "=== List of S3 Buckets ===\n"
resp.buckets.each do |bucket|
    print "#{bucket.name}\n"
end

