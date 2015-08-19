require 'clockwork'
# Require the full rails environment if needed
require './config/boot'
require './config/environment'
include Clockwork

# Define the jobs
handler do |job|
  if job.eql?('mq.email_process')
    EmailData.process
  end
end

# Define the schedule
every(2.minutes, 'mq.email_process')
