require 'haveapi/cli'

module Vpsfree
  class Cli < HaveAPI::CLI::Cli
    protected
    def default_url
      'https://api.vpsfree.cz'
    end
  end
end