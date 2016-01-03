module Rathole
  module Redis
    class << self
      attr_accessor :configuration
      attr_accessor :connection
    end

    class Configuration
      attr_accessor :url
      attr_accessor :namespace

      def initialize
        self.url = "redis://localhost:6379/1"
        self.namespace = "rathole"
      end
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration)
      configuration
    end

    def self.connect
      Rathole::Redis.connection = ::Redis::Namespace.new(
        Rathole::Redis.configuration.namespace,
        :redis => ::Redis.new(:url => configuration.url)
      )
    end
  end

  def self.redis
    Rathole::Redis.connection
  end
end

Rathole::Redis.configure do |config|
  if Rails.env.development?
    config.url = "redis://localhost:6379/1"
    config.namespace = "rathole-development"
  elsif Rails.env.test?
    config.url = "redis://localhost:6379/10"
    config.namespace = "rathole-test"
  end
end

Rathole::Redis.connect
