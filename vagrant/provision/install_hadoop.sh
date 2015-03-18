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

echo "Installing Hadoop"

set -e

HADOOP_VER="2.6.0"

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d /opt/hadoop-$HADOOP_VER ]; then
    if [ ! -f /var/cache/www/hadoop-$HADOOP_VER.tar.gz ]; then
      wget -O /var/cache/www/hadoop-$HADOOP_VER.tar.gz http://apache.mesi.com.ar/hadoop/common/hadoop-$HADOOP_VER/hadoop-$HADOOP_VER-tar.gz
    fi
    tar -C /opt -xzf /var/cache/www/hadoop-$HADOOP_VER.tar.gz
    cd /opt
    ln -s hadoop-$HADOOP_VER hadoop
    cd /opt/hadoop
    chown -R hadoop:hadoop .
    sudo -u hadoop $SCRIPT_DIR/helper_install_hadoop.sh
fi
echo "Done install Hadoop"
