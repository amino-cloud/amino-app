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

class DatasourceMetadata < Metadata
  attr_accessor :id, :name, :description, :featureIds, :bucketIds

  def self.from_java java_object
    return nil if java_object.nil?
    DatasourceMetadata.new id: java_object.id, name: java_object.name, description: java_object.description,
                           featureIds: java_object.featureIds, bucketIds: java_object.bucketIds
  end
end