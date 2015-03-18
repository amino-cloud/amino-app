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

require 'pp'
module FeaturesHelper

  def get_feature_metadata_by_id(id)
    puts "features_md_id_get=#{id}"
    feature = Rails.cache.read(feature_by_id: id)
    return feature if feature
    @md = @amino_service.get_metadata unless @md
    feature = @md.get_feature(id)
    if feature
      Rails.cache.write({feature_by_id: id}, feature)
      feature
    else
      dummy = FeatureMetadata.new(name: 'Unamed', id:'nil')
      Rails.cache.write({feature_by_id: id}, dummy)
      dummy
    end
  end

  def get_feature_name(id)
    get_feature_metadata_by_id(id).name
  end

  def get_begin_range(feature_metadata, feat)
    return nil if feature_metadata.type.nil?
    if 'nominal'.casecmp(feature_metadata.type) == 0 || 'restriction'.casecmp(feature_metadata.type) == 0
      feat.value
    elsif 'RATIO'.casecmp(feature_metadata.type) == 0 || 'INTERVAL'.casecmp(feature_metadata.type) == 0
      feat.min
    elsif 'date'.casecmp(feature_metadata.type) == 0 || 'datehour'.casecmp(feature_metadata.type) == 0
      feat.timestamp_from
    end
  end

  def get_end_range(feature_metadata, feat)
    return nil if feature_metadata.type.nil?
    if 'nominal'.casecmp(feature_metadata.type) == 0 || 'restriction'.casecmp(feature_metadata.type) == 0
      feat.value
    elsif 'RATIO'.casecmp(feature_metadata.type) == 0 || 'INTERVAL'.casecmp(feature_metadata.type) == 0
      feat.max
    elsif 'date'.casecmp(feature_metadata.type) == 0 || 'datehour'.casecmp(feature_metadata.type) == 0
      feat.timestamp_to
    end
  end

  def populate_feature_stats(query_service, feature_box)
    unless feature_box.begin_range.to_s.empty? || feature_box.end_range.to_s.empty?
      feature_count = query_service.get_count_for_hypothesis_feature feature_box.feature.id, feature_box.bucket_name, feature_box.begin_range, feature_box.end_range
      feature_box.uniqueness = query_service.get_uniqueness feature_box.feature.id, feature_box.bucket_name, feature_count
      feature_box.count = feature_count
    end
    feature_box
  end
end