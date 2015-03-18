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

echo "Installing SUDOERs"

function add_secure_path {
current_path=$(sudo augtool get /files/etc/sudoers/Defaults/secure_path | cut -f2 -d=)

asked="*$1*"

if [[ "$current_path" != $asked ]]; then
  echo -n $1 ": "
  sudo augtool set /files/etc/sudoers/Defaults/secure_path "$current_path:$1"
fi
}

for f in /vagrant/vagrant/startup /opt/zookeeper/bin /opt/java/bin /opt/accumulo/bin /opt/hadoop/bin /opt/maven/bin
do
  add_secure_path $f
done


export wheel_spec_index=$(augtool match /files/etc/sudoers/spec[./user=\"%wheel\"] | cut -d= -f1 | cut -d/ -f5 | cut -d[ -f2 | cut -d] -f1)

result=$(augtool get /files/etc/sudoers/spec[$wheel_spec_index]/host_group/command/runas_user)

if [[ $result != *ALL* ]]; then
augtool <<EOF
ins spec after /files/etc/sudoers/spec[$wheel_spec_index]
set /files/etc/sudoers/spec[last()]/user "%wheel"
set /files/etc/sudoers/spec[last()]/host_group/host "ALL"
set /files/etc/sudoers/spec[last()]/host_group/command "ALL"
set /files/etc/sudoers/spec[last()]/host_group/command/runas_user "ALL"
set /files/etc/sudoers/spec[last()]/host_group/command/tag "NOPASSWD"
rm  /files/etc/sudoers/spec[$wheel_spec_index]
save
EOF
fi

