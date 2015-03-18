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

echo "Installing Listening"

set -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

cat -> /etc/profile.d/listening.sh <<EOF
#!/bin/bash

listening () {
	sudo lsof -Pni | grep '(LISTEN)' | awk 'BEGIN {printf "%-15s %5s %21s\n", "Command", "PID", "PORT"} {printf "%-15s %5s %21s\n", \$1,\$2,\$9}'
}
EOF
chmod uog+rx /etc/profile.d/listening.sh
