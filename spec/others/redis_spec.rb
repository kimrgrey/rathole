require "rails_helper"

describe Rathole::Redis do
  describe "#connection" do
    it "should be namespaced" do
      expect(Rathole::Redis.connection.namespace).to eq("rathole-test")
    end

    it "should be shared" do
      connection_1 = Rathole::Redis.connection
      connection_2 = Rathole::Redis.connection

      expect(connection_1).to equal(connection_2)
    end

    it "should be shortcuted by Rathole.redis" do
      connection_1 = Rathole::Redis.connection
      connection_2 = Rathole.redis

      expect(connection_1).to equal(connection_2)
    end

    it "shoud return OK for flushdb" do
      expect(Rathole::Redis.connection.flushdb).to eq("OK")
    end
  end
end
