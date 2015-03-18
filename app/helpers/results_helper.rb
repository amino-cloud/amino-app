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

module ResultsHelper
  def list_results(params)
    start = params[:start] || 0
    count = params[:start] || Amino::Util::java_long_max_value
    query = @amino_service.get_query
    query.get_result start, count
  end

  def get_result(params)
    owner = params[:owner]
    result_id = params[:id]
    bad_request 'result_id is required' unless result_id
    query = @amino_service.get_query
    query_result = query.get_result owner, result_id
    query_result.hypothesis_at_runtime.features.each { |feature|
      feature.name = get_feature_name(feature.feature_metadata_id)
    }
    query_result
  end

  def create_result(params)
    owner = params[:owner]
    inquiry_id = params[:inquiry_id]
    max_results = params[:max_results] || 2000
    justification = params[:justification]
    timeout = parse_time_span params[:timeout]
    query = @amino_service.get_query
    bad_request 'inquiry_id is required' unless inquiry_id
    bad_request 'max_results is required to be >0' unless max_results && max_results > 0
    unless justification
      md = @amino_service.get_metadata
      inquiry = md.get_hypothesis owner, inquiry_id
      justification = inquiry.justification
    end
    query.create_result owner, inquiry_id, max_results, justification, timeout[:unit], timeout[:length]
  end

  def delete_result(params)
    id = params[:id]
    query = @amino_service.get_query
    query.delete_result id
  end


  private
  include FeaturesHelper

  def parse_time_span(str)
    return {length: nil, unit: nil} if str.nil?
    val = str[/\d+/]
    unit = str[/\a-zA-Z+/]
    {length: val, unit: unit}
  end
end
