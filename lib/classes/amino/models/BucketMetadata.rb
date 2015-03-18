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

class BucketMetadata < Metadata
  attr_accessor :name, :display_name, :visibility, :bt_visibility, :domain_id_name, :domain_id_description, :timestamp


  def self.from_java java_object
    return nil if java_object.nil?
    BucketMetadata.new id: java_object.id, name: java_object.name, display_name: java_object.displayName,
                       visibility: java_object.visibility, bt_visibility: java_object.btVisibility,
                       domain_id_name: java_object.domainIdName, domain_id_description: java_object.domainIdDescription,
                       timestamp: java_object.timestamp
  end
end