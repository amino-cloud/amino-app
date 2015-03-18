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

echo "hadoop-user.sh"

set -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if getent passwd hadoop > /dev/null 2>&1; then
 echo "hadoop user already exist."
else
  useradd -s /bin/bash -m hadoop
  
  export USER_HOME=/home/hadoop
  
  sudo -u hadoop mkdir $USER_HOME/.ssh
  sudo -u hadoop chmod og-rwx $USER_HOME/.ssh
  sudo -u hadoop ssh-keygen -t dsa -P '' -f $USER_HOME/.ssh/id_dsa
  cat $USER_HOME/.ssh/id_dsa.pub >> $USER_HOME/.ssh/authorized_keys

augtool <<EOF
    rm /files/etc/security/limits.conf/domain[.="hadoop"][./type="soft" and ./item="nofile"]
    rm /files/etc/security/limits.conf/domain[.="hadoop"][./type="hard" and ./item="nofile"]
    set /files/etc/security/limits.conf/domain[last()+1] hadoop
    set /files/etc/security/limits.conf/domain[last()]/type soft
    set /files/etc/security/limits.conf/domain[last()]/item nofile
    set /files/etc/security/limits.conf/domain[last()]/value 65536
    set /files/etc/security/limits.conf/domain[last()+1] hadoop
    set /files/etc/security/limits.conf/domain[last()]/type hard
    set /files/etc/security/limits.conf/domain[last()]/item nofile
    set /files/etc/security/limits.conf/domain[last()]/value 65536
    save
    print /files/etc/security/limits.conf/domain[.="hadoop"]
EOF
fi
