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

echo "Accumulo-install-helper"
set -e

if [ "$USER" != "hadoop" ]; then
   echo "This script must be run as hadoop" 1>&2
   exit 1
fi

cd /opt/accumulo
export JAVA_HOME=${JAVA_HOME:-/opt/java}
echo "JAVA_HOME=$JAVA_HOME"

./bin/accumulo init --instance-name instance --password secret --clear-instance-name
./bin/start-all.sh
