require 'haveapi/cli'

module VpsFree
  module Client
    class Cli < HaveAPI::CLI::Cli
      protected
      def default_url
        'https://api.vpsfree.cz'
      end
    end
  end
end
