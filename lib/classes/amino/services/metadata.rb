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

class Amino::Services::Metadata
  include Contracts

  def initialize implementation
    @implementation = implementation
  end

  Contract ArrayOf[String] => ArrayOf[Amino::Common::DatasourceMetadata]
  def list_data_sources visibility
    @implementation.list_data_sources visibility
  end

  Contract String, ArrayOf[String] => ArrayOf[Amino::Common::FeatureMetadata]
  def list_features datasource_id, visibility
    @implementation.list_features datasource_id, visibility
  end

  Contract String, ArrayOf[String] => ArrayOf[Amino::Common::BucketMetadata]
  def list_buckets datasource_id, visibility
    @implementation.list_buckets datasource_id, visibility
  end

  Contract String, ArrayOf[String] => Amino::Common::DatasourceMetadata
  def get_data_source datasource_id, visibility
    @implementation.get_data_source datasource_id, visibility
  end

  Contract String, ArrayOf[String] => Amino::Common::FeatureMetadata
  def get_feature id, visibility
    @implementation.get_feature id, visibility
  end

  Contract String, ArrayOf[String] => Amino::Common::BucketMetadata
  def get_bucket id, visibility
    @implementation.get_bucket id, visibility
  end

  Contract String, String, String, ArrayOf[String] => Amino::Common::Entity::Hypothesis
  def get_hypothesis user_id, owner, hypothesis_id, visibility
    @implementation.get_hypothesis user_id, owner, hypothesis_id, visibility
  end

  Contract String, ArrayOf[String] => ArrayOf[Amino::Common::Entity::Hypothesis]
  def list_hypotheses user_id, visibility
    @implementation.list_hypotheses user_id, visibility
  end
  
  Contract Amino::Common::Entity::Hypothesis, String, ArrayOf[String] => Amino::Common::Entity::Hypothesis
  def create_hypothesis hypothesis, user_id, visibility
    @implementation.create_hypothesis hypothesis, user_id, visibility
  end

  Contract Amino::Common::Entity::Hypothesis, String, ArrayOf[String] => Amino::Common::Entity::Hypothesis
  def update_hypothesis hypothesis, requester, visibility
    @implementation.update_hypothesis hypothesis, requester, visibility
  end
  
  Contract String, ArrayOf[String] => None
  def delete_hypothesis owner, id, visibility
    @implementation.delete_hypothesis owner, id, visibility
  end
end