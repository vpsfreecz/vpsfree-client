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
    Usage: vpsfreectl [options] <resource> <action> [objects ids] [-- [parameters]]
        -a, --api URL                    API URL
            --list-versions              List all available API versions
            --list-resources VERSION     List all resource in API version
            --list-actions VERSION       List all resources and actions in API version
        -r, --raw                        Print raw response as is
        -u, --username USER              User name
        -p, --password PASSWORD          Password
        -v, --[no-]verbose               Run verbosely
        -h, --help                       Show this message

#### Examples

List VPS:

    vpsfreectl vps list -u yourlogin
    
List OS templates:

    vpsfreectl os_template list -u yourlogin

Create VPS:

    vpsfreectl vps create -u yourlogin -- --hostname myvps --os-template-id 26

Delete VPS #1000:

    vpsfreectl vps delete 1000 -u yourlogin
    
List IP addresses:

    vpsfreectl vps.ip_address list -u yourlogin
 
### Client library
```ruby
require 'vpsfree/client'

api = Vpsfree::Client.new
api.login('yourname', 'yourpassword')

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
