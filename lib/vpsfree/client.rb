require 'haveapi/client'

module VpsFree
  module Client
    class Client < HaveAPI::Client::Client
      def initialize(opts = {})
        super('https://api.vpsfree.cz', opts)
      end
    end

    # Shortcut to {VpsFree::Client::Client.new}
    def self.new(*args)
      Client.new(*args)
    end
  end
end
