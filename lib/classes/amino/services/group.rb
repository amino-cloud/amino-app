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

class Amino::Services::Group
  include Contracts
  
  def initialize implementation
    @implementation = implementation
  end

  Contract String, ArrayOf[String] => Bool
  def verify_group_exists group, visibilities
    @implementation.verify_group_exists group, visibilities
  end
  
  Contract String, ArrayOf[String] => Bool
  def verify_user_exists user, visibilities
    @implementation.verify_user_exists user, visibilities
  end

  Contract Amino::Common::Requests::AddUsersRequest => None
  def add_to_group request
    @implementation.add_to_group request
  end

  Contract Amino::Common::Requests::CreateGroupRequest => None
  def create_group request
    @implementation.create_group request
  end

  Contract String, ArrayOf[String] => ArrayOf[String]
  def list_groups user_id, visibilities
    @implementation.list_groups user_id, visibilities
  end
  
  Contract String, String, ArrayOf[String], ArrayOf[String] => None
  def remove_users_from_group requester, group, members, visibilities
    @implementation.remove_users_from_group requester, group, members, visibilities
  end

  Contract String, String, ArrayOf[String], ArrayOf[String] => None
  def remove_user_from_groups requester, user_id, groups, visibilities
    @implementation.remove_user_from_groups requester, user_id, groups, visibilities
  end

  Contract String, String, ArrayOf[String] => Amino::Common::Group
  def get_group requester, group, visibilities
    @implementation.get_group requester, group, visibilities
  end

  Contract String, String => ArrayOf[String]
  def get_groups_for_user user_id, visibilities
    @implementation.get_groups_for_user user_id, visibilities
  end

  Contract String, ArrayOf[String], Maybe[Bool] => ArrayOf[Amino::Common::Entity::Hypothesis]
  def get_group_hypotheses_for_user user_id, visibilities, user_owned = false
    @implementation.get_group_hypotheses_for_user user_id, visibilities, user_owned
  end
end