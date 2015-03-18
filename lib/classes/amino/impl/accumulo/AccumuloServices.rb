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

class Amino::Services::Impl::Accumulo::AccumuloServices

  def initialize(args)
    @persistence_service = args[:persistence_service]
    @exe_service = args[:exe_service]
  end

  def get_amino_services(controller_context)
    Amino::Services::Impl::Accumulo::AuthenticatedServices.new({persistence_service: @persistence_service,
                                                                exe_service: @exe_service,
                                                                controller_context: controller_context})
  end

  def close
  end
end

class Amino::Services::Impl::Accumulo::AuthenticatedServices
  def initialize(args)
    @persistence_service = args[:persistence_service]
    @exe_service = args[:exe_service]
    @controller_context = args[:controller_context] || ApplicationController.new
    @authorizations = @controller_context.session[:authorizations]
    @user = @controller_context.session[:username]
  end

  def get_group
    unless @group
      @group = Amino::Services::Impl::Accumulo::Group.new @persistence_service, @user, @authorizations
    end
    @group
  end

  def get_metadata
    unless @metadata
      @metadata = Amino::Services::Impl::Accumulo::Metadata.new @persistence_service, get_group, @user, @authorizations
    end
    @metadata
  end

  def get_query
    unless @query
      @query = Amino::Services::Impl::Accumulo::Query.new @persistence_service, get_metadata, @exe_service
    end
    @query
  end
end