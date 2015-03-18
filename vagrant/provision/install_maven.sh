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

echo "Installing Maven"

MAVEN_VER="3.2.5"
set -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ ! -d /opt/apache-maven-$MAVEN_VER ]; then
  if [ ! -f /var/cache/www/apache-maven-$MAVEN_VER-bin.tar.gz ]; then
    wget -O /var/cache/www/apache-maven-$MAVEN_VER-bin.tar.gz http://mirror.reverse.net/pub/apache/maven/maven-3/$MAVEN_VER/binaries/apache-maven-$MAVEN_VER-bin.tar.gz
  fi

  tar --no-same-owner --no-same-permissions -C /opt -xzf /var/cache/www/apache-maven-$MAVEN_VER-bin.tar.gz
  
  cat -> /etc/profile.d/maven.sh <<EOF
#!/bin/bash
pathmunge /opt/maven/bin
EOF
  chmod uog+rx /etc/profile.d/maven.sh

  cd /opt
  ln -s apache-maven-$MAVEN_VER maven

fi
