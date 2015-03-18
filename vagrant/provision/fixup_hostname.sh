#!/bin/bash
#   Copyright (C) 2013-2014 Computer Sciences Corporation
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

echo "Fixup Hostname"

set -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

cat > /etc/hostname <<EOF
amino-vm
EOF

hostname amino-vm

augtool set /files/etc/sysconfig/network/HOSTNAME amino-vm

cat > /etc/hosts <<EOF
127.0.0.1	localhost
192.168.33.15	amino-vm

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF

if [ ! -f /etc/ssh/ssh_known_hosts ]; then
  ssh-keyscan -H amino-vm >> /etc/ssh/ssh_known_hosts
  ssh-keyscan -H localhost >> /etc/ssh/ssh_known_hosts
  ssh-keyscan -H 0.0.0.0 >> /etc/ssh/ssh_known_hosts
fi

/etc/init.d/network restart
