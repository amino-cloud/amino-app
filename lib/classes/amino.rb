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

module Amino
  module Common
    include_package 'com._42six.amino.common'
    module Util
      module Concurrent
        include_package 'com._42six.amino.common.util.concurrent'
      end
    end
    module Entity
      include_package 'com._42six.amino.common.entity'
    end

    module Requests
      include_package 'com._42six.amino.common.query.requests'

      module Bta
        include_package 'com._42six.amino.common.query.requests.bta'
      end
    end

    module Responses
      include_package 'com._42six.amino.common.query.responses'
    end
  end

  module Security
  end
end
# TODO clean this up

amino_root = Rails.root, 'lib', 'classes', 'amino'

require File.join amino_root, 'util.rb'

require File.join amino_root, 'services.rb'
Loader.load File.join(amino_root, 'services'), /.*\.rb/

require File.join(amino_root, 'models', 'Metadata.rb')
Loader.load File.join(amino_root, 'models'), /.*\.rb/

require File.join amino_root, 'impl', 'impl.rb'
Loader.load File.join(amino_root, 'impl'), /.*\.rb/

require File.join(amino_root, 'user.rb')

Loader.load File.join(amino_root, 'security'), /.*\.rb/

