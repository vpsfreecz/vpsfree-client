vpsFree-Client
==============
vpsFree-Client is a Ruby CLI and client library for vpsFree.cz API. It is based
on vpsadmin-client, which is in turn based on haveapi-client. Check haveapi-client
for more extensive documentation.

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
        -u, --api URL                    API URL
        -a, --auth METHOD                Authentication method
            --list-versions              List all available API versions                      
            --list-auth-methods [VERSION]
                                         List available authentication methods
            --list-resources [VERSION]   List all resource in API version
            --list-actions [VERSION]     List all resources and actions in API version
            --version VERSION            Use specified API version
        -c, --columns                    Print output in columns
        -H, --no-header                  Hide header row
        -L, --list-parameters            List output parameters
        -o, --output PARAMETERS          Parameters to display, separated by a comma
        -r, --rows                       Print output in rows
        -s, --sort PARAMETER             Sort output by parameter
            --save                       Save credentials to config file for later use
            --raw                        Print raw response as is
            --timestamp                  Display Datetime parameters as timestamp
            --utc                        Display Datetime parameters in UTC
            --localtime                  Display Datetime parameters in local timezone
            --date-format FORMAT         Display Datetime in custom format
        -v, --[no-]verbose               Run verbosely
            --client-version             Show client version
            --protocol-version           Show protocol version
            --check-compatibility        Check compatibility with API server
        -h, --help                       Show this message

    Commands:
    vps remote_console VPS_ID            Open VPS remote console

#### Examples
Authenticate using token and save it to config for later use:

    vpsfreectl --auth token --save user current

Note that the token will be stored in your home directory in plain text and
anyone having access to it will be able to login as yourself into vpsAdmin.

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

Open remote VPS console:

    vpsfreectl vps remote_console $vps_id
 
### Client library
```ruby
require 'vpsfree/client'

api = VpsFree::Client::Client.new
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
