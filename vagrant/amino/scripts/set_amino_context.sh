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


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

sudo -u hadoop /opt/hadoop/bin/hadoop fs -mkdir -p /amino/iterators
sudo -u hadoop /opt/hadoop/bin/hadoop fs -put -f $SCRIPT_DIR/../hdfs/amino/iterators/*.jar /amino/iterators
sudo -u hadoop /opt/hadoop/bin/hadoop fs -chmod -R og+rwx /amino

/opt/accumulo/bin/accumulo shell -u root -p secret <<EOF
config -s general.vfs.context.classpath.amino=hdfs://amino-vm:9000/amino/iterators/[^.].*.jar
setauths -u root -s U,FOUO,UNCLASSIFIED
EOF
exit 0
