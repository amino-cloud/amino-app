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

module InquireHelper
  def features_to_feature_boxes(inquiry)
    query = @amino_service.get_query
    inquiry.features = inquiry.features.map do |feat|
      fmd = get_feature_metadata_by_id feat.feature_metadata_id
      fb = FeatureBox.new id:fmd.id, feature:fmd, bucket_name: get_bucket_name(inquiry.bucket_id),
                                  min: fmd.min, max: fmd.max, uniqueness: feat.uniqueness, count: feat.count,
                                  begin_range: get_begin_range(fmd, feat), end_range: get_end_range(fmd, feat)
      populate_feature_stats(query, fb) unless fb.count > 0 && fb.uniqueness > 0
      fb
    end
    inquiry
  end
  private
  include FeaturesHelper
  include BucketHelper

  def get_bucket_name(bucket_id)
    get_bucket_by_id(bucket_id).name
  end
end
