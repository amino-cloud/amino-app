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

class Amino::Services::Impl::Accumulo::Metadata
  attr_reader :user, :visibilities

  def initialize(persistence_service, group_service, user, visibilities)
    @user = user
    @visibilities = visibilities.to_java :string
    @metadata_service = Amino::Services::Impl::Accumulo::Helper::Classes::AccumuloMetadataService.new persistence_service, group_service.get_group_service_impl
  end

  def list_data_sources
    @metadata_service.listDataSources(@visibilities).map{|i| ::DatasourceMetadata.from_java i}
  end

  def list_features(datasource_id)
    @metadata_service.listFeatures(datasource_id, @visibilities).map{|i| FeatureMetadata.from_java i}
  end

  def list_buckets(datasource_id)
    @metadata_service.listBuckets(datasource_id, @visibilities).map{|i| BucketMetadata.from_java i }
  end

  def get_data_source(datasource_id)
    DatasourceMetadata.from_java @metadata_service.getDataSource(datasource_id, @visibilities)
  end

  def get_feature(id)
    FeatureMetadata.from_java @metadata_service.getFeature(id, @visibilities)
  end

  def get_bucket(id)
    BucketMetadata.from_java @metadata_service.getBucket(id, @visibilities)
  end

  def get_hypothesis(owner, hypothesis_id)
    owner = @user if owner.nil?
    Hypothesis.from_java @metadata_service.getHypothesis(@user, owner, hypothesis_id, @visibilities)
  end

  def list_hypotheses(user_id = nil)
    user_id = @user if user_id.nil?
    @metadata_service.listHypotheses(user_id, @visibilities).map{|i| Hypothesis.from_java i }
  end
  
  def create_hypothesis(hypothesis)
    hypothesis.owner = @user if hypothesis.owner.nil?
    hypothesis.can_edit = [hypothesis.owner] if hypothesis.can_edit.nil?
    hypothesis.can_view = hypothesis.can_edit if hypothesis.can_view.nil?
    java_hypothesis = hypothesis.to_java
    Hypothesis.from_java @metadata_service.createHypothesis java_hypothesis, @user, @visibilities
  end

  def update_hypothesis(hypothesis)
    java_hypothesis = hypothesis.to_java
    Hypothesis.from_java @metadata_service.updateHypothesis java_hypothesis, @user, @visibilities
  end
  
  def delete_hypothesis(id)
    @metadata_service.deleteHypothesis @user, id, @visibilities
  end

  def get_impl
    @metadata_service
  end
end