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

require 'java'
class Amino::Services::Impl::Accumulo::Query
  def initialize(persistence_service, metadata_service, exe_service)
    @exe_service = exe_service
    @query_service = Amino::Services::Impl::Accumulo::Helper::Classes::AccumuloQueryService.new persistence_service, metadata_service.get_impl, exe_service
    @user = metadata_service.user
    @visibilities = metadata_service.visibilities
  end

  def list_results(start = 0, count = Util.java_long_max_value)
    @query_service.listResults(start, count, @user, @visibilities).map {|x| QueryResult.from_java x}
  end

  def get_result(result_owner, query_id)
    result_owner = @user if result_owner.nil?
    QueryResult.from_java @query_service.getResult(@user, result_owner, query_id, @visibilities)
  end

  def create_result(owner, hypothesis_id, max_results, justification, timeout = nil, timeout_unit = nil)
    timeout_unit = Amino::Util.parse_time_unit timeout_unit
    owner = @user if owner.nil?
    if timeout.nil?
      result = @query_service.createResult owner, hypothesis_id, max_results, justification, @user, @visibilities
    else
      result = @query_service.createResult owner, hypothesis_id, max_results, justification, @user, @visibilities, timeout, timeout_unit
    end
    QueryResult.from_java result
  end

  def delete_result(id)
    @query_service.deleteResult @user, id, @visibilities
  end

  def get_hypotheses_by_bucket_values(by_value_request)
    @query_service.getHypothesesByBucketValues by_value_request
  end

  def create_non_persisted_hypothesis_list_for_bucket_value(datasource_id, bucket_id, bucket_values, justification, feature_ids, timeout = nil, timeout_unit = nil)
    @query_service.createNonPersistedHypothesisListForBucketValue datasource_id, bucket_id, bucket_values, @visibilities, @user, justification, feature_ids, timeout, timeout_unit
  end

  def get_count_for_hypothesis_feature(feature_metadata_id, bucket_name, begin_range, end_range)
    @query_service.getCountForHypothesisFeature feature_metadata_id, bucket_name, begin_range.to_s, end_range.to_s, @visibilities
  end

  def get_uniqueness(feature_id, bucket_name, count)
    @query_service.getUniqueness feature_id, bucket_name, count, @visibilities
  end

end