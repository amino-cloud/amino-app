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

class Amino::Services::Impl::Accumulo::Group
  def initialize(persistence_service, user, visibilities)
    @user = user
    @visibilities = visibilities
    @group_service = Amino::Services::Impl::Accumulo::Helper::Classes::AccumuloGroupService.new persistence_service
  end

  def get_group_service_impl
    @group_service
  end

  def verify_group_exists(group)
    @group_service.verifyGroupExists group, @visibilities
  end
  
  def verify_user_exists(user)
    @group_service.verifyUserExists user, @visibilities
  end

  def add_to_group(request)
    @group_service.addToGroup request
  end

  def create_group(request)
    @group_service.createGroup request
  end

  def list_groups
    @group_service.listGroups @user, @visibilities
  end
  
  def remove_users_from_group(group, members)
    @group_service.removeUsersFromGroup @user, group, members, @visibilities
  end

  def remove_user_from_groups(user_id, groups)
    @group_service.removeUserFromGroups @user, user_id, groups, @visibilities
  end

  def get_group(group)
    @group_service.getGroup @requester, group, @visibilities
  end

  def get_groups_for_user
    @group_service.getGroupsForUser @user, @visibilities
  end

  def get_group_hypotheses_for_user(user_owned)
    @group_service.getGroupHypothesesForUser @user, @visibilities, user_owned
  end
end