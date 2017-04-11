class SQS

  CREATE_QUEUE_DEFAULT_ATTR = {
    ReceiveMessageWaitTimeSeconds: "20"
  }

  RECV_MESSAGE_DEFAULT_OPS = {
      max_number_of_messages: 1,
      visibility_timeout: 1,
      wait_time_seconds: 1
  }

  def initialize(sqsClient)
    @sqsClient = sqsClient
  end

  def queue_exists?(queue_name)
    list = @sqsClient.list_queues.queue_urls
    
    result = list.select do |url|
      name = url[url.rindex("/") + 1 .. url.length]
      name.start_with? queue_name
    end

    result.length > 0
  end

  def create_queue(queue_name, attributes = {})
    opts = CREATE_QUEUE_DEFAULT_ATTR.merge(attributes)
    @sqsClient.create_queue({
      queue_name: queue_name,
      attributes: opts
    })
  end

  def receive_message(queue_url, attributes = {}) 
    opts = RECV_MESSAGE_DEFAULT_OPS.merge(attributes)
    opts[:queue_url] = queue_url
    @sqsClient.receive_message(opts)
  end

  def delete_message(queue_url, receipt_handle)
    @sqsClient.delete_message({
      queue_url: queue_url,
      receipt_handle: receipt_handle
    })
  end

  def get_queue_url(queue_name)
    queue = @sqsClient.get_queue_url({
      queue_name: queue_name
    })

    raise "Unable to find queue: #{queue_name}" if queue.nil?

    queue.queue_url
  end

  def send_string_message(queue_url, message_body)
    @sqsClient.send_message({
      queue_url: queue_url,
      message_body: message_body,
      message_attributes: {
        "RequestId" => {
          string_value: "0xF00BAA",
          data_type: "String"
        }
      }
    })
  end
end