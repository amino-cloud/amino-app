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

module Amino::Security::BasicAuth
  USERS = YAML.load File.read File.join Rails.root, 'config', 'basic_auth_user_manifest.yml'

  # returns a new Amino::User object if valid, throws if not
  def self.authenticate controller_context
    retval = nil

    controller_context.authenticate_or_request_with_http_basic('Amino') do |username, password|
      if USERS[username] == password
        retval = Amino::User.new username, [:U, :UNCLASSIFIED]
      else
        raise SecurityError, "User not authorized: #{username}"
      end
    end

    retval
  end
end