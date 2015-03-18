#!/bin/bash

echo "Helper install hadoop"
set -e

if [ "$USER" != "hadoop" ]; then
   echo "This script must be run as hadoop" 1>&2
   exit 1
fi


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd /opt/hadoop

export JAVA_HOME=${JAVA_HOME:-/opt/java}
echo "JAVA_HOME=$JAVA_HOME"

cat > ./etc/hadoop/core-site.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!--
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
-->


<!-- Put site-specific property overrides in this file. -->

<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://amino-vm:9000</value>
    </property>
</configuration>
EOF

cp $SCRIPT_DIR/hdfs-site.xml ./etc/hadoop/hdfs-site.xml
cp $SCRIPT_DIR/yarn-site.xml ./etc/hadoop/yarn-site.xml
cp $SCRIPT_DIR/mapred-site.xml ./etc/hadoop/mapred-site.xml

./bin/hdfs namenode -format
./sbin/start-dfs.sh
./bin/hdfs dfs -mkdir /user
./bin/hdfs dfs -mkdir /user/hadoop
./bin/hdfs dfs -mkdir /user/vagrant
./bin/hdfs dfs -chown vagrant:vagrant /user/vagrant

./sbin/start-yarn.sh
