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

class QueryResult
  attr_accessor :id, :owner, :timestamp, :result_count, :hypothesis_id, :hypothesis_name, :bucket_id,
                :hypothesis_at_runtime, :error, :result_set

  def initialize(params = {})
    params.each { |key, value| send "#{key}=", value }
  end

  def self.from_java(j)
    return nil if j.nil?
    QueryResult.new id:j.id, owner:j.owner, hypothesis_id: j.hypothesisid, hypothesis_name:j.hypothesisname,
                    bucket_id:j.bucketid, timestamp: Time.at(j.timestamp / 1000).to_datetime,
                    result_count:j.result_count, hypothesis_at_runtime: Hypothesis.from_java(j.hypothesis_at_runtime),
                    error: j.error, result_set: j.result_set.map {|i| QueryEntry.new i.bucketName}
  end

end