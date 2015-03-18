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

module Api
  module V1
    class Api::V1::FeatureboxController < BaseController
      def index
        not_found 'Can not list feature boxes'
      end
      def show
        bucket_name = params[:bucket_name]
        feature_id = params[:id]

        bad_request 'bucket_name is required' unless bucket_name
        bad_request 'feature_id is required' unless feature_id

        md = @amino_service.get_metadata
        query = @amino_service.get_query
        md_feature_info = md.get_feature feature_id
        feature_info = FeatureBox.new feature: md_feature_info, id: md_feature_info.id, bucket_name:bucket_name,
                                      min: md_feature_info.try(:min).try(:get, bucket_name),
                                      max: md_feature_info.try(:max).try(:get, bucket_name),
                                      count: 0, uniqueness: 0
        puts feature_info
        feature_info.begin_range = params[:begin_range] || feature_info.min
        feature_info.end_range =  params[:end_range] || feature_info.max
        populate_feature_stats(query, feature_info)
        render json: feature_info
      end
      private
      include FeaturesHelper
    end
  end
end
