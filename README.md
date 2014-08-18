vpsFree-Client
==============
vpsFree-Client is a Ruby CLI and client library for vpsFree.cz API.

## Installation

Add this line to your application's Gemfile:

    gem 'vpsfree-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vpsfree-client

## Usage
### CLI
    $ vpsfreectl -h
    Usage: haveapi-cli [options] <resource> <action> [objects ids] [-- [parameters]]
        -u, --api URL                    API URL
        -a, --auth METHOD                Authentication method
            --list-versions              List all available API versions
            --list-auth-methods [VERSION]
                                         List available authentication methods
            --list-resources [VERSION]   List all resource in API version
            --list-actions [VERSION]     List all resources and actions in API version
        -r, --raw                        Print raw response as is
        -s, --save                       Save credentials to config file for later use
        -v, --[no-]verbose               Run verbosely
        -h, --help                       Show this message

#### Examples
Authenticate using token and save it to config for later use:

    vpsfreectl --auth token --save vps list

Show action parameters:

    vpsfreectl vps create -h

List VPS:

    vpsfreectl vps list
    
List OS templates:

    vpsfreectl os_template list

Create VPS:

    vpsfreectl vps create -- --hostname myvps --os-template-id 26

Delete VPS #1000:

    vpsfreectl vps delete 1000
    
List IP addresses:

    vpsfreectl vps.ip_address list
 
### Client library
```ruby
require 'vpsfree/client'

api = Vpsfree::Client.new
api.login(:basic, user: 'yourname', password: 'yourpassword')

response = api.vps.index
p response.ok?
p response.response

p api.os_template.index

p api.vps.create({
  hostname: 'myvps',
  os_template_id: 26
})

p api.vps(1000).delete
p api.vps(1000).delete!

p api.vps.ip_address.index
```
