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

echo "Modifying PATH"

set -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

cat > /etc/profile.d/amino-cloud.sh <<EOF
export JAVA_HOME=/opt/java
export PATH=\$JAVA_HOME/bin:\$PATH:/opt/accumulo/bin:/opt/zookeeper/bin:/opt/hadoop/bin
EOF
chmod uog+rx /etc/profile.d/amino-cloud.sh
