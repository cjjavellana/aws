class S3 

  def initialize(s3client)
    @client = s3client
  end

  def bucket_exists(bucket_name)
    begin
      @client.head_bucket({:bucket => bucket_name}).on_success { |resp| return true }
    rescue StandardError => error
      return false
    end
  end

  def create_bucket(bucket_name)
    puts "Creating bucket #{bucket_name}"
    @client.create_bucket({
        bucket: bucket_name,
        create_bucket_configuration: {location_constraint: "ap-southeast-1"}
      })
  end

  def delete_bucket(bucket_name)
    puts "Deleting bucket #{bucket_name}"
    @client.delete_bucket({:bucket => bucket_name})
  end

  def upload_local_file(file_path, bucket_name)
    puts "Uploading #{file_path} to #{bucket_name}"

    File.open(file_path, 'rb') do |file|
      file_name = File.basename(file_path)
      @client.put_object(bucket: bucket_name, key: file_name, body: file)
    end
  end
end