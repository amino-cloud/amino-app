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

if Rails.configuration.amino_interface_enabled
  if Rails.configuration.amino_interface == :accumulo
    acc_conf = Rails.configuration.accumulo_config
    accumulo_persistence_service = Amino::Services::Impl::Accumulo::Helper.create_persistence_service acc_conf[:instance_name], acc_conf[:zookeepers], acc_conf[:accumulo_user], acc_conf[:accumulo_password], acc_conf[:use_mock]

    timed_service = Amino::Util.create_timed_user_execution_service Rails.configuration.amino.timed_user_execution_service
    Amino::Client = Amino::Services::Impl::Accumulo::AccumuloServices.new({persistence_service: accumulo_persistence_service, exe_service: timed_service })
    at_exit do
      begin
        Amino::Client.close
      rescue Exception => e
        puts e
      end
    end
  else
    raise NotImplementedError, "An interface matching #{Rails.configuration.amino_interface} has not been implemented."
  end
end