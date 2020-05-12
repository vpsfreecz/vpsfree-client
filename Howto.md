# Howto manage VPS with vpsfreectl

VPS and other resources can be managed via web GUI or using REST API.
Complete description of API and clients is available [here](https://kb.vpsfree.org/manuals/vps/api).

REST API is based on objects. Object ID is required as an unique identifier.

Here is brief list of actions available via API:
1. Stop/start/restart VPS
2. Create/delete VPS
3. Assign IPs to interface in VPS
4. Assign public key to VPS

## Prerequisites
1. Active account in vpsFree
2. Free resources - if you would like to create new VPS
3. [vpsfree-client](https://github.com/vpsfreecz/vpsfree-client/blob/master/README.md) installed from Git.

## Table of content
1. Description of infrastructure
2. Basic description of vpsfreectl
2. Login
3. Get details about resource
    0. Howto get resource ID
    1. Get ID of VPS based on hostname
    2. Get ID of interface based on VPS ID
    3. Get ID of IPv4
    4. Get ID of IPv6
    5. Get ID of public key
    6. Get ID of Location
    7. Get ID of Environment
3. Create VPS
4. Assign IPv4 and IPv6
5. Assign public key to VPS
6. Stop/start/restart VPS

## Description of infrastructure
There are two infrastructure in vpsFree:
1. OpenVZ - Legacy environment
2. vpsAdminIS - Current environment

This manual discuss resource handling in vpsAdminOS.
There are different resources available, for example:
1. User
2. VPS
3. IP address
4. Network interface
You can manage them, based on your privilege level

## Basic description of vpsfreectl
Verify if vpsfreectl is correctly installed:
```
which vpsfreectl
```
Every resource and action have --help parameter.

## Login
Login is required to access all resources in vpsFree infrastructure.
There are two available login methods:
1. Basic
2. Token
This manual is based on Token authentication.
```
vpsfreectl --auth token --save user current --token-lifetime permanent --user YOUR_USERNAME
```
SECURITY NOTE: --token-lifetime permanent is security risk. Anyone can use your access in case of compromitation.
Use --token-interval $((24\*60\*60)) to get token valid one day.

Authentication token is stored in:
```
~/.haveapi-client.yml
```

In case of login problem delete ~/.haveapi-client.yml file.

## Get details about resource
REST API is based on objects. Object ID is required as an unique identifier for many operations.
Resource ID is available via GET method. Different selectors (Input parameters) are available for every resource.
Below is list of selectors for VPS
```
vpsfreectl vps index --help
Usage: /root/.rbenv/versions/2.5.7/bin/vpsfreectl [options] <resource> <action> [objects ids] [-- [parameters]]
(... shortened ...)
Action description:
List VPS
Input parameters:
        --offset [OFFSET]            The offset of the first object
        --limit [LIMIT]              The number of objects to retrieve
        --node [NODE]                Filter by node
        --location [LOCATION]        Filter by location
        --environment [ENVIRONMENT]  Filter by environment
        --user-namespace-map [USER_NAMESPACE_MAP]
                                     UID/GID mapping
        --os-template [OS_TEMPLATE]  OS template
        --hostname-any [HOSTNAME_ANY]
                                     Hostname_any
        --hostname-exact [HOSTNAME_EXACT]
                                     Hostname_exact
        --object-state [OBJECT_STATE]
                                     Object state
    -h, --help                       Show this message

```
VPS can be selected based on exact hostname:
```
vpsfreectl vps index -- --hostname-exact test.domain.tld
             VPS id:  9999
               User:  username (#999)
           Hostname:  test.domain.tld
    Manage hostname:  true
        OS template:  CentOS 7 (#74)
       DNS resolver:  ns{1,2}.prg.vpsfree.cz (#24)
               Node:  node2.stg (#401)
            Dataset:  16503 (#17517)
             Memory:  4096
               Swap:  0
                CPU:  8
   Maintenance lock:  no
 Maintenance reason:  -
       Object state:  active
         Expiration:  2020-06-11 16:46:18 +0200
            Running:  true
      Process count:  114
        Used memory:  23
          Used swap:  -
    Used disk space:  750
             Uptime:  4710
            Loadavg:  0.0
           Cpu_user:  -
           Cpu_nice:  -
         Cpu_system:  -
           Cpu_idle:  100.0
         Cpu_iowait:  -
            Cpu_irq:  -
        Cpu_softirq:  -
```
Output filters are available. Use -Hc -o id to get ID of resource only:
```
vpsfreectl vps index --help
Usage: /root/.rbenv/versions/2.5.7/bin/vpsfreectl [options] <resource> <action> [objects ids] [-- [parameters]]
    (... shortened ...)
    -c, --columns                    Print output in columns
    -H, --no-header                  Hide header row
    -o, --output PARAMETERS          Parameters to display, separated by a comma
    -r, --rows                       Print output in rows

#vpsfreectl vps index -Hc -o id -- --hostname-exact test.domain.tld
  16503
```

## Get ID of resource - examples
Useful examples howto get ID of resource are available in this section.
### Get ID of VPS based on hostname
```
vpsfreectl vps index -Hc --o id  -- --hostname-exact test.domain.tld
```
### Get ID of interface based on VPS ID
VPS ID is required to get ID of network_interfaces assigned in particular VPS.
```
vpsfreectl vps index -Hc --o id  -- --hostname-exact test.domain.tld
9999
vpsfreectl network_interface index -Hc -o id -- --vps 9999
9199
```
### Get ID of IPv4
```
vpsfreectl ip_address index -Hc -o id -- --addr 10.20.30.40
```
### Get ID of IPv6
IPv6 needs to be searched based on subnet.
```
vpsfreectl ip_address index -Hc -o id -- --addr 2a03:3c40:ff:4e::
9919
```
### Get ID of public key
User ID and VPS ID is required to get public keys assigned to particular user.
User ID can be found in web GUI, or in VPS details.
```
vpsfreectl user.public_key index USER_ID -Hc -o id
9991
vpsfreectl vps index -Hc --o id  -- --hostname-exact test.domain.tld
9999
vpsfreectl vps deploy_public_key 9999 -- --public-key 9991
```
### Get ID of Location
### Get ID of Environment
### Get ID of OS Template

## Create VPS
All parameters in previous section are required to create VPS and assign IPs.
Note:
--ipv4 0 and --ipv6 0 assign zero IP addresses to VPS.
Particular IPs are assigned in next step.
```
vpsfreectl vps create -- \
    --hostname "VPS_HOSTNAME" \
    --os_template "ID_OF_OS_TEMPLATE" \
    --environment "ID_OF_ENVIRONMENT" \
    --location "ID_OF_LOCATION"  \
    --ipv4 0 \
    --ipv6 0
```