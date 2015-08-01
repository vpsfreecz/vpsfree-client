require 'haveapi/client'

module Vpsfree
  module Client
    class Client < HaveAPI::Client::Client
      def initialize(v=nil)
        super('https://api.vpsfree.cz', v)
      end
    end
  end
end
