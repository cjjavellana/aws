class EC2

  def initialize(ec2)
    @ec2 = ec2
  end

  def create_instance
    tag = "demo-day"
    instances = @ec2.create_instances({
      dry_run: false,
      image_id: "ami-0103cd62", # required
      min_count: 1, # required
      max_count: 1, # required
      key_name: "christian_mbp15",
      instance_type: "t2.micro", 
      monitoring: {
        enabled: true, # required
      },
      disable_api_termination: true,
      instance_initiated_shutdown_behavior: "stop", # accepts stop, terminate
      network_interfaces: [{
        device_index: 0,
        subnet_id: "subnet-008fe877",               # ChristianVPC
        groups: ["sg-7ed5981b"],                    # Hackable Security Group
        delete_on_termination: true,
        # private_ip_addresses: [{
        #  private_ip_address: private_ip,
        #  primary: true
        #  }],
        associate_public_ip_address: true
        }],
      ebs_optimized: false,
    })

    instances.each do |instance|
      instance.create_tags({
          dry_run: false,
          tags: [{
              key: "Name",
              value: tag
            }]
        })

      puts "Waiting for instance #{instance.id} to initialize..."
      instance.wait_until_running
      puts "Instance #{instance.id} initialization complete!"
    end

    ids = instances.map { |m| m.instance_id }
    ec2_client = Aws::EC2::Client.new(region: 'ap-southeast-1')
    resp = ec2_client.describe_instances({
        dry_run: false,
        instance_ids: ids
      })
    ip = resp.reservations[0].instances[0].public_ip_address

    puts "Tag: #{tag} Instance Id: #{ids}; Public Ip: #{ip}"
  end

end