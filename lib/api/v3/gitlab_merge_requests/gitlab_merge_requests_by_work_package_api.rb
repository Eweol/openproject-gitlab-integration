#-- encoding: UTF-8

#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2021 Ben Tey
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
# Copyright (C) 2012-2021 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See docs/COPYRIGHT.rdoc for more details.
#++

module API
  module V3
    module GitlabMergeRequests
      class GitlabMergeRequestsByWorkPackageAPI < ::API::OpenProjectAPI
        after_validation do
          authorize(:show_gitlab_content, context: @work_package.project)
          @gitlab_merge_requests = @work_package.gitlab_merge_requests
        end

        resources :gitlab_merge_requests do
          get do
            path = api_v3_paths.gitlab_merge_requests_by_work_package(@work_package.id)
            GitlabMergeRequestCollectionRepresenter.new(@gitlab_merge_requests,
                                                        @gitlab_merge_requests.count,
                                                        self_link: path,
                                                        current_user: current_user)
          end
        end
      end
    end
  end
end
