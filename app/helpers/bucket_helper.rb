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

module BucketHelper
  def get_bucket_by_id(id)
    bucket = Rails.cache.read(bucket_by_id: id)
    return bucket if bucket
    @md = @amino_service.get_metadata unless @md
    bucket = @md.get_bucket(id)
    if bucket
      Rails.cache.write({bucket_by_id: id}, bucket)
      bucket
    else
      dummy = BucketMetadata.new(name: 'Unamed', display_name: 'Unamed', id:'nil')
      Rails.cache.write({bucket_by_id: id}, dummy)
      dummy
    end
  end
end