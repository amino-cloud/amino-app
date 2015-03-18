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

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate

  private
  def authenticate
    begin
      if session[:username].nil?
        # implementations of SecurityService#authenticate should:
        # a) return a User object if enough information is present to identify user
        # b) return nil if more information will be requested (basic auth, etc)
        # c) throw a SecurityError if user cannot be authenticated
        @user = Amino::SecurityService.authenticate self
        unless @user.nil?
          session[:username] = @user.username
          session[:authorizations] = @user.authorizations
        end
      else
        @user = Amino::SecurityService.authenticate self
      end
      @amino_service = Amino::Client.get_amino_services(self)
    rescue SecurityError => e
      Rails.logger.warn e.inspect
      render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    end
  end
end
