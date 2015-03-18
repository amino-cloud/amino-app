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

class HypothesisFeature
  attr_accessor :id, :feature_metadata_id, :type, :operator, :value, :min, :max, :date_time_type,
                :relative_date_time_range, :timestamp_from, :timestamp_to, :visibility, :bt_visibility, :count,
                :uniqueness, :include, :name

  def initialize(params = {})
    params.each { |k, v| send "#{k}=", v }
    fix_values_based_on_type
  end

  def fix_values_based_on_type
    if 'nominal'.casecmp(self.type) == 0 || 'restriction'.casecmp(self.type) == 0
      self.value = self.min.to_s if self.value.nil?
      self.min = 0
      self.max = 0
    elsif 'RATIO'.casecmp(self.type) == 0 || 'INTERVAL'.casecmp(self.type)  == 0
      self.min = self.max = self.value if self.min.nil? && self.max.nil?
      self.min = self.min.to_f
      self.max = self.max.to_f
      self.value = nil
    elsif 'date'.casecmp(self.type) == 0 || 'datehour'.casecmp(self.type) == 0
      self.timestamp_from = self.min if self.timestamp_from.nil?
      self.timestamp_to = self.max if self.timestamp_to.nil?
      self.timestamp_from = self.timestamp_from.to_i
      self.timestamp_to = self.timestamp_to.to_i
      self.min = self.max = 0
      self.value = nil
    end
  end

  def self.from_java f
    HypothesisFeature.new id:f.id, feature_metadata_id:f.featureMetadataId, type:f.type,
                          operator:f.operator, value:f.value, min:f.min, max:f.max,
                          date_time_type:f.dateTimeType, relative_date_time_range:f.relativeDateTimeRange,
                          timestamp_from:timestamp_to_datetime(f.timestampFrom), timestamp_to:timestamp_to_datetime(f.timestampTo),
                          visibility:f.visibility, bt_visibility:f.btVisibility, count:f.count,
                          uniqueness:f.uniqueness, include:f.include

  end

  def to_java
    feature = Amino::Common::Entity::HypothesisFeature.new
    feature.id = id
    feature.featureMetadataId = feature_metadata_id
    feature.type = type
    feature.operator = operator
    feature.value = value
    feature.min = min
    feature.max = max
    feature.dateTimeType = date_time_type
    feature.relativeDateTimeRange = relative_date_time_range
    feature.timestampFrom = timestamp_from.to_f * 1000
    feature.timestampTo = timestamp_to.to_f * 1000
    feature.visibility = visibility
    feature.btVisibility = bt_visibility
    feature.count = count
    feature.uniqueness = uniqueness
    feature.include = include
    feature
  end

  private
  def self.timestamp_to_datetime timestamp
    return nil unless timestamp
    Time.at(timestamp/1000).to_datetime
  end
end