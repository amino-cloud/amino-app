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

echo "Installing Java"

set -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ ! -d /opt/jdk1.8.0_20 ]; then
    if [ ! -f /var/cache/www/jdk-8u20-linux-x64.gz ]; then
      wget -O /var/cache/www/jdk-8u20-linux-x64.gz https://s3.amazonaws.com/files.tasermonkeys.com/jdk-8u20-linux-x64.gz
    fi

    tar --no-same-owner --no-same-permissions -C /opt -xzf /var/cache/www/jdk-8u20-linux-x64.gz
fi

cd /opt
ln -s jdk1.8.0_20 java

echo "JAVA_HOME=/opt/java" >> /etc/environment


