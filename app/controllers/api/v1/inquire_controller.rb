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
    class InquireController < BaseController
      include InquireHelper
      def index
        owner = params[:owner]
        md = @amino_service.get_metadata
        previous_inquiries = md.list_hypotheses owner
        shared_inquiries = []
        render json: {previous: previous_inquiries, shared: shared_inquiries}
      end

      def show
        owner = params[:owner]
        id = params[:id]
        md = @amino_service.get_metadata
        bad_request 'id is required' unless id

        inquiry = features_to_feature_boxes(md.get_hypothesis(owner, id))

        render json: inquiry
      end

      def create
        bad_request '>0 features are required' unless params[:features] and not params[:features].empty?
        bad_request 'hypothesis name is required' unless params[:name] and not params[:name].empty?
        bad_request 'hypothesis justification is required' unless params[:justification] and not params[:justification].empty?
        bad_request 'bucket.id is required' unless params[:bucket][:id]
        bad_request 'datasource.id is required' unless params[:datasource][:id]

        features = _map_to_features params[:features]
        hypothesis = Hypothesis.new name: params[:name], bucket_id: params[:bucket][:id], datasource_id: params[:datasource][:id],
                                    justification: params[:justification], features: features

        #TODO: figure out visibility
        hypothesis.visibility = 'UNCLASSIFIED'
        hypothesis.bt_visibility = 'UNCLASSIFIED'

        hypothesis.queries = []

        md = @amino_service.get_metadata
        created = md.create_hypothesis hypothesis
        render json: created
      end

      def update
        owner = params[:owner]
        id = params[:id]
        md = @amino_service.get_metadata
        bad_request 'id is required' unless id
        bad_request 'inquiry is required' unless id
        inquiry = md.get_hypothesis owner, id
        updated_inquiry = params[:inquire]
        updated_inquiry.each do |name, value|
          if name == 'datasource'
            inquiry.datasource_id = value[:id]
          elsif name == 'bucket'
            inquiry.bucket_id = value[:id]
          elsif name == 'features'
            inquiry.features = _map_to_features value
          elsif not ['id'].include? name
            inquiry.send "#{name}=", value
          end
        end
        updated_hypothesis = md.update_hypothesis inquiry
        render json: updated_hypothesis
      end

      def destroy
        id = params[:id]
        md = @amino_service.get_metadata
        bad_request 'id is required' unless id
        bad_request 'inquiry is required' unless id
        md.delete_hypothesis id
        render json: {message: 'Successfully deleted.', id: id, deleted: true}
      end

      private
      def _map_to_features(features)
        features.map do |f|
          HypothesisFeature.new feature_metadata_id: f[:id], type: f[:type],
                                min: f[:begin_range], max: f[:end_range],
                                visibility: f[:visibility], bt_visibility: f[:bt_visibility]
        end
      end
    end
  end
end
