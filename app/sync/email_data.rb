require "bunny"

class EmailData

  def self.process

    Rails.logger.info  "Starting Email Data process"

    Rails.logger.info ConnectionMgmt.get("RABBITMQ")

    # Start a communication session with RabbitMQ

    conn = Bunny.new(ConnectionMgmt.get("RABBITMQ"))
    conn.start

    ch  = conn.create_channel
    x   = ch.fanout("todo.publishemail")
    q   = ch.queue("", :exclusive => true)

    q.bind(x)

    q.subscribe(:block => true) do |delivery_info, metadata, payload|
      Rails.logger.info "Received #{payload}"
    end

    Rails.logger.info  "Ending Email Data process"

  end

end
