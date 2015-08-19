
class ConnectionMgmt

  def self.get(service_type)

    u = ""

    if service_type == "REDIS"
      u = ENV['REDIS_URL']

      if ENV['VCAP_SERVICES'].present?
        vcap = JSON.parse(ENV['VCAP_SERVICES'])["redis"]
        credentials = vcap.first["credentials"]
        u = credentials["uri"]
      end
    elsif service_type == "RABBITMQ"
      u = ENV['RABBITMQ_URL']

      if ENV['VCAP_SERVICES'].present?
        vcap = JSON.parse(ENV['VCAP_SERVICES'])["rabbitmq3"]
        credentials = vcap.first["credentials"]
        u = credentials["uri"]
      end

    end

    u
  end

end