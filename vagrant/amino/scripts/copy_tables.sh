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

sudo -u hadoop /opt/hadoop/bin/hadoop fs -mkdir -p /amino
sudo -u hadoop /opt/hadoop/bin/hadoop fs -put -f $SCRIPT_DIR/../hdfs/amino/tables /amino/.
sudo -u hadoop /opt/hadoop/bin/hadoop fs -chmod -R og+rwx /amino

/opt/accumulo/bin/accumulo shell -u root -p secret <<EOF
importtable amino_bitmap_bitLookup /amino/tables/amino_bitmap_bitLookup
importtable amino_bitmap_byBucket /amino/tables/amino_bitmap_byBucket
importtable amino_feature_lookup /amino/tables/amino_feature_lookup
importtable amino_group_hypothesis_lookup /amino/tables/amino_group_hypothesis_lookup
importtable amino_group_membership /amino/tables/amino_group_membership
importtable amino_group_metadata /amino/tables/amino_group_metadata
importtable amino_hypothesis /amino/tables/amino_hypothesis
importtable amino_metadata /amino/tables/amino_metadata
importtable amino_query_result /amino/tables/amino_query_result
importtable amino_reverse_bitmap_byBucket /amino/tables/amino_reverse_bitmap_byBucket
importtable amino_reverse_feature_lookup /amino/tables/amino_reverse_feature_lookup


createtable amino_bitmap_bitLookup
createtable amino_bitmap_byBucket
createtable amino_feature_lookup
createtable amino_group_hypothesis_lookup
createtable amino_group_membership
createtable amino_group_metadata
createtable amino_hypothesis
createtable amino_metadata
createtable amino_query_result
createtable amino_reverse_bitmap_byBucket
createtable amino_reverse_feature_lookup

EOF

exit 0

# to Export tables from another installation

# offline backed_up_amino_bitmap_bitLookup
# offline backed_up_amino_bitmap_byBucket
# offline backed_up_amino_feature_lookup
# offline backed_up_amino_group_hypothesis_lookup
# offline backed_up_amino_group_membership
# offline backed_up_amino_group_metadata
# offline backed_up_amino_hypothesis
# offline backed_up_amino_metadata
# offline backed_up_amino_query_result
# offline backed_up_amino_reverse_bitmap_byBucket
# offline backed_up_amino_reverse_feature_lookup

# exporttable -t backed_up_amino_bitmap_byBucket /tmp/backed_up_amino_bitmap_byBucket
# exporttable -t backed_up_amino_feature_lookup /tmp/backed_up_amino_feature_lookup
# exporttable -t backed_up_amino_group_hypothesis_lookup /tmp/backed_up_amino_group_hypothesis_lookup
# exporttable -t backed_up_amino_group_membership /tmp/backed_up_amino_group_membership
# exporttable -t backed_up_amino_group_metadata /tmp/backed_up_amino_group_metadata
# exporttable -t backed_up_amino_hypothesis /tmp/backed_up_amino_hypothesis
# exporttable -t backed_up_amino_metadata /tmp/backed_up_amino_metadata
# exporttable -t backed_up_amino_query_result /tmp/backed_up_amino_query_result
# exporttable -t backed_up_amino_reverse_bitmap_byBucket /tmp/backed_up_amino_reverse_bitmap_byBucket
# exporttable -t backed_up_amino_reverse_feature_lookup /tmp/backed_up_amino_reverse_feature_lookup

# online backed_up_amino_bitmap_bitLookup
# online backed_up_amino_bitmap_byBucket
# online backed_up_amino_feature_lookup
# online backed_up_amino_group_hypothesis_lookup
# online backed_up_amino_group_membership
# online backed_up_amino_group_metadata
# online backed_up_amino_hypothesis
# online backed_up_amino_metadata
# online backed_up_amino_query_result
# online backed_up_amino_reverse_bitmap_byBucket
# online backed_up_amino_reverse_feature_lookup

# 
# sudo hadoop distcp -f /tmp/amino_bitmap_bitLookup/distcp.txt file:///tmp/amino/amino_bitmap_bitLookup
# sudo hadoop distcp -f /tmp/backed_up_amino_bitmap_byBucket/distcp.txt file:///tmp/amino/amino_bitmap_byBucket
# sudo hadoop distcp -f /tmp/backed_up_amino_feature_lookup/distcp.txt file:///tmp/amino/amino_feature_lookup
# sudo hadoop distcp -f /tmp/backed_up_amino_group_hypothesis_lookup/distcp.txt file:///tmp/amino/amino_group_hypothesis_lookup
# sudo hadoop distcp -f /tmp/backed_up_amino_group_membership/distcp.txt file:///tmp/amino/amino_group_membership
# sudo hadoop distcp -f /tmp/backed_up_amino_group_metadata/distcp.txt file:///tmp/amino/amino_group_metadata
# sudo hadoop distcp -f /tmp/backed_up_amino_hypothesis/distcp.txt file:///tmp/amino/amino_hypothesis
# sudo hadoop distcp -f /tmp/backed_up_amino_metadata/distcp.txt file:///tmp/amino/amino_metadata
# sudo hadoop distcp -f /tmp/backed_up_amino_query_result/distcp.txt file:///tmp/amino/amino_query_result
# sudo hadoop distcp -f /tmp/backed_up_amino_reverse_bitmap_byBucket/distcp.txt file:///tmp/amino/amino_reverse_bitmap_byBucket
# sudo hadoop distcp -f /tmp/backed_up_amino_reverse_feature_lookup/distcp.txt file:///tmp/amino/amino_reverse_feature_lookup
