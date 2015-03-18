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

class HomeController < ApplicationController

  class InquiryEntry
    attr_accessor :id, :name, :timestamp
    def initialize(id, name, timestamp)
      self.id = id
      self.name = name
      self.timestamp = timestamp
    end
  end

  def index

  end

  def datasource
    md = @amino_service.get_metadata
    @datasources = md.list_data_sources
  end


  def features
    md = @amino_service.get_metadata
    @features = md.list_features params[:feature_id]
  end

  def buckets
    md = @amino_service.get_metadata
    @buckets = md.list_buckets params[:datasource_id]
  end

  def rnd_time
    date2 = Time.now
    date1 = date2 - 7.days
    Time.at((date2.to_i - date1.to_i)*rand + date1.to_i)
  end

end
