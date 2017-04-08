require 'aws-sdk'
require 'byebug'
require './s3'

### Setup Environment
bucket_name = "s3-file-upload-temp-repo"
s3 = Aws::S3::Client.new({region: 'ap-southeast-1'})

### Connect to s3
s3client = S3.new(s3)

# Check if bucket exists
bucket_exists = s3client.bucket_exists bucket_name

# Create if missing
s3client.create_bucket bucket_name unless bucket_exists

### Perform file upload here
s3client.upload_local_file './CIS_Red_Hat_Enterprise_Linux_6_Benchmark_v1.2.0.pdf',bucket_name

## Clean up
#s3client.delete_bucket bucket_name

