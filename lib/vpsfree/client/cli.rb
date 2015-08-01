require 'haveapi/cli'

module Vpsfree
  module Client
    class Cli < HaveAPI::CLI::Cli
      protected
      def default_url
        'https://api.vpsfree.cz'
      end
    end
  end
end
