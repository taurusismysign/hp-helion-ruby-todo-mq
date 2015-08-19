require "bunny"

class Todo < ActiveRecord::Base
  after_create :send_email

  def send_email
    if notify_email.present?

      Rails.logger.info "Notify email present : Sending on MQ"

      #put the details on MQ - the receiver will read this information
      #and will act (it will send the email with details of the TODO)

      Rails.logger.info ConnectionMgmt.get("RABBITMQ")

      conn = Bunny.new(ConnectionMgmt.get("RABBITMQ"))
      conn.start

      # open a channel
      ch = conn.create_channel

      x = ch.fanout("todo.publishemail")

      # publish a message to the default exchange which then gets routed to this queue
      x.publish(self.to_json)
      conn.stop

      Rails.logger.info "Publish complete on MQ"

    end
  end

end
