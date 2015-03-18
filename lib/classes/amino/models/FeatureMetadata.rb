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

class FeatureMetadata < Metadata

  attr_accessor :name, :visibility, :bt_visibility, :api_version, :job_version, :description, :namespace,
                :type, :datasources, :min, :max, :allowed_values, :feature_fact_count, :bucket_value_count,
                :averages, :standard_deviations, :ratio_bins, :top_n


  def self.from_java i
    return nil if i.nil?
    FeatureMetadata.new id: i.id, name: i.name, visibility: i.visibility, bt_visibility:i.btVisibility,
                        api_version: i.api_version, job_version:i.job_version, description:i.description,
                        namespace:i.namespace, type:i.type, datasources:i.datasources, min:i.min,
                        max:i.max, allowed_values:i.allowedValues, feature_fact_count:i.featureFactCount,
                        bucket_value_count:i.bucketValueCount, ratio_bins:i.ratioBins,
                        averages:i.averages, standard_deviations:i.standardDeviations, top_n:i.topN
  end
end