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


echo "Installing Accumulo"
set -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

ACCUMULO_VER="1.6.2"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d /opt/accumulo-$ACCUMULO_VER ]; then
    if [ ! -f /var/cache/www/accumulo-$ACCUMULO_VER-bin.tar.gz ]; then
      wget -O /var/cache/www/accumulo-$ACCUMULO_VER-bin.tar.gz http://apache.mirrors.hoobly.com/accumulo/$ACCUMULO_VER/accumulo-$ACCUMULO_VER-bin.tar.gz
    fi
    tar -C /opt -xzf /var/cache/www/accumulo-$ACCUMULO_VER-bin.tar.gz
    cd /opt
    ln -s accumulo-$ACCUMULO_VER accumulo
    cd /opt/accumulo
    cp conf/examples/512MB/standalone/* conf/.
    cp $SCRIPT_DIR/masters conf/.
    cp $SCRIPT_DIR/gc conf/.
    cp $SCRIPT_DIR/slaves conf/.
    cp $SCRIPT_DIR/tracers conf/.
    cp $SCRIPT_DIR/accumulo-site.xml conf/.
    cp $SCRIPT_DIR/accumulo-env.sh conf/.

    chown hadoop:hadoop -R .
    sudo -u hadoop $SCRIPT_DIR/helper_install_accumulo.sh
fi

