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
module Amino::Util
  LONG_MAX = (2**63)-1

  def self.java_long_max_value
    LONG_MAX
  end


  # noinspection RubyClassMethodNamingConvention
  def self.create_timed_user_execution_service(args = {})
    if args[:max_task_per_user]
      tues = Amino::Common::Util::Concurrent::TimedUserExecutionService.new args[:max_task_per_user]
    else
      tues = Amino::Common::Util::Concurrent::TimedUserExecutionService.new
    end
    [:keep_alive_units, :default_timeout_units, :max_timeout_units].each do |key|
      args[key] = parse_time_unit args[key] if args[key]
    end
    args.each { |key, value| tues.send "set_#{key}", value unless key == :max_task_per_user }
    tues
  end

  def self.parse_time_unit(timeout_unit)
    java_import java.util.concurrent.TimeUnit
    m = {
        :ms => TimeUnit::MILLISECONDS,
        :ns => TimeUnit::NANOSECONDS,
        :µ => TimeUnit::MICROSECONDS,
        :s => TimeUnit::SECONDS,
        :min => TimeUnit::MINUTES,
        :hour => TimeUnit::HOURS,
        :days => TimeUnit::DAYS
    }
    return TimeUnit::SECONDS if timeout_unit.nil?
    m[timeout_unit] || TimeUnit::SECONDS
  end
end