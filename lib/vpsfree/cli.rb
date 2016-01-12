require 'vpsadmin/cli'

module VpsFree
  module CLI
    module Commands ; end

    class Cli < VpsAdmin::CLI::Cli
      protected
      def default_url
        'https://api.vpsfree.cz'
      end
    end
  end
end
