require 'haveapi/client'

module Vpsfree
  class Client < HaveAPI::Client::Client
    def initialize(v=nil)
      super('https://api.vpsfree.cz', v)
    end
  end
end
