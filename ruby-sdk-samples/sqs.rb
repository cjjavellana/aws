class SQS

  CREATE_QUEUE_DEFAULT_ATTR = {
    ReceiveMessageWaitTimeSeconds: "20"
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
end