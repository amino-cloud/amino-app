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

echo "Installing Zookeeper"

set -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d /opt/zookeeper-3.4.6 ]; then
    if [ ! -f /var/cache/www/zookeeper-3.4.6.tar.gz ]; then
      wget -O /var/cache/www/zookeeper-3.4.6.tar.gz http://www.carfab.com/apachesoftware/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
    fi
    tar -C /opt -xzf /var/cache/www/zookeeper-3.4.6.tar.gz
    cd /opt/zookeeper-3.4.6
    cp conf/zoo_sample.cfg conf/zoo.cfg
    cp $SCRIPT_DIR/zkEnv.sh ./bin/.
    chown -R hadoop:hadoop .
    cd /opt
    ln -s zookeeper-3.4.6 zookeeper
    cd zookeeper
    sudo -u hadoop ./bin/zkServer.sh start
fi
echo "Zookeeper Installed"
