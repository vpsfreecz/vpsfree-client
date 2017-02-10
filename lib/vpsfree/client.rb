require 'haveapi/client'

module VpsFree
  module Client
    class Client < HaveAPI::Client::Client
      def initialize(opts = {})
        super('https://api.vpsfree.cz', opts)
      end
    end
  end
end
