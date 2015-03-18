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

class Amino::Services::Query
  include Contracts

  def initialize implementation
    @implementation = implementation
  end

  Contract String, ArrayOf[String], Num, Num => ArrayOf[Amino::Common::Entity::QueryResult]
  def list_results user_id, visibility, start = 0, count = Util.java_long_max_value
    @implementation.list_results start, count, user_id, visibility
  end

  Contract String, String, String, ArrayOf[String] => Amino::Common::Entity::QueryResult
  def get_result requester, result_owner, query_id, visibility
    @implementation.get_result requester, result_owner, query_id, visibility
  end

  Contract String, String, Num, String, String, ArrayOf[String], Maybe[Num], Maybe[Java::JavaUtilConcurrent::TimeUnit] => Amino::Common::Entity::QueryResult
  def create_result owner, hypothesis_id, max_results, justification, user_id, visibility, timeout = nil, timeout_unit = nil
    @implementation.create_result owner, hypothesis_id, max_results, justification, user_id, visibility, timeout, timeout_unit
  end

  Contract String, String, ArrayOf[String] => None
  def delete_result owner, id, visibility
    @implementation.delete_result owner, id, visibility
  end

  Contract Amino::Common::Requests::Bta::BtaByValuesRequest => ArrayOf[Amino::Common::Entity::Hypothesis]
  def get_hypotheses_by_bucket_values bta_by_values_request
    @implementation.get_hypotheses_by_bucket_values bta_by_values_request
  end

  Contract String, String, ArrayOf[String], ArrayOf[String], String, String, ArrayOf[String], Maybe[Num], Maybe[Java::JavaUtilConcurrent::TimeUnit] => ArrayOf[Amino::Common::Entity::Hypothesis]
  def create_non_persisted_hypothesis_list_for_bucket_value datasource_id, bucket_id, bucket_values, visibility, user_id, justification, feature_ids, timeout = nil, timeout_unit = nil
    @implementation.create_non_persisted_hypothesis_list_for_bucket_value datasource_id, bucket_id, bucket_values, visibility, user_id, justification, feature_ids, timeout = nil, timeout_unit = nil
  end

  Contract String, String, String, String, ArrayOf[String] => Num
  def get_count_for_hypothesis_feature feature_metadata_id, bucket_name, begin_range, end_range, visibility
    @implementation.get_count_for_hypothesis_feature feature_metadata_id, bucket_name, begin_range, end_range, visibility
  end

  Contract String, String, Num, ArrayOf[String] => Num
  def get_uniqueness feature_id, bucket_name, count, visibility
    @implementation.get_uniqueness feature_id, bucket_name, count, visibility
  end
end