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


set -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

SCRIPT_DIR=/vagrant/vagrant/provision

export JAVA_HOME=/opt/java
export PATH=$JAVA_HOME/bin:$PATH

mkdir -p /tmp/install
cd /tmp/install

mkdir -p /var/cache/www

$SCRIPT_DIR/install_utils.sh
$SCRIPT_DIR/install_listening.sh
$SCRIPT_DIR/enable_swap.sh
$SCRIPT_DIR/install_java7.sh
$SCRIPT_DIR/modify_path.sh
$SCRIPT_DIR/fixup_hostname.sh
$SCRIPT_DIR/hadoop_user.sh
$SCRIPT_DIR/install_zookeeper.sh
$SCRIPT_DIR/install_hadoop.sh
$SCRIPT_DIR/install_accumulo.sh
$SCRIPT_DIR/install_maven.sh
$SCRIPT_DIR/install_sudoers.sh
$SCRIPT_DIR/install_amino_tables.sh
