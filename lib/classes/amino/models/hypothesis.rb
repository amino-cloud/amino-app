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

class Hypothesis
  attr_accessor :id, :name, :owner, :bucket_id, :datasource_id, :can_edit, :can_view,
                :justification, :bucket_value, :bt_visibility, :visibility,
                :features, :created, :updated, :executed,
                :queries
  def initialize(params = {})
    params.each { |key, value| send "#{key}=", value }
  end

  def self.from_java(j)
    return nil if j.nil?
    Hypothesis.new id:j.id, name:j.name, owner:j.owner, bucket_id:j.bucketid, datasource_id:j.datasourceid,
                   can_edit:j.canEdit.to_a, can_view:j.canView.to_a,
                   justification:j.justification,
                   bucket_value:j.bucketValue, bt_visibility:j.btVisibility, visibility:j.visibility,
                   features:j.hypothesisFeatures.map{|f| HypothesisFeature.from_java f },
                   created:to_date_time(j.created), updated:to_date_time(j.updated), executed:to_date_time(j.executed),
                   queries:j.queries.to_a

  end

  def self.to_date_time i
    return nil if i.nil?
    Time.at(i / 1000).to_datetime
  end

  def to_java
    hypothesis = Amino::Common::Entity::Hypothesis.new
    hypothesis.id = id
    hypothesis.name = name
    hypothesis.owner = owner
    hypothesis.bucketid = bucket_id
    hypothesis.datasourceid = datasource_id
    hypothesis.canEdit = can_edit
    hypothesis.canView = can_view
    hypothesis.justification = justification
    hypothesis.bucketValue = bucket_value
    hypothesis.btVisibility = bt_visibility
    hypothesis.visibility = visibility
    hypothesis.hypothesisFeatures = features.map{ |f| f.to_java }.to_java_set
    hypothesis.created = (created.to_f * 1000) if created
    hypothesis.updated = (updated.to_f * 1000) if updated
    hypothesis.executed = (executed.to_f * 1000) if executed
    hypothesis.queries = queries.to_java_sorted_set
    hypothesis
  end

end

class Array
  def to_java_set
    s = Java::JavaUtil::HashSet.new
    s.addAll self
    s
  end

  def to_java_sorted_set
    s = Java::JavaUtil::TreeSet.new
    s.addAll self
    s
  end
end