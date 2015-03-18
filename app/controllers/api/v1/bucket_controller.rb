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
    class BucketController < BaseController
      def index
        ds_id = params[:datasource_id]
        bad_request 'datasource_id is required' unless ds_id

        md = @amino_service.get_metadata
        render json: md.list_buckets(ds_id)
      end

      def show
        id = params[:id]
        bad_request 'Id is required' unless id
        md = @amino_service.get_metadata
        render json: md.get_bucket(id)
      end
    end


  end
end
