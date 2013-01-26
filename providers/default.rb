# vim: ts=2 sts=2 sw=2 et sta
#
# Cookbook Name:: timezone
# Provider:: default
#
# Author:: Kirill Kouznetsov <agon.smith@gmail.com>
#
# Copyright 2013, Kirill Kouznetsov.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :set do
  package "tzdata"

  tz_f = file "/etc/timezone" do
    owner "root"
    group "root"
    mode 0644
    notifies :run, 'bash[dpkg-reconfigure tzdata]'
    content "#{new_resource.timezone}\n"
  end

  bash 'dpkg-reconfigure tzdata' do
    user 'root'
    code "/usr/sbin/dpkg-reconfigure -f noninteractive tzdata"
    action :nothing
  end

  if tz_f.updated_by_last_action?
    new_resource.updated_by_last_action(true)
  end
end

# vim: ts=2 sts=2 sw=2 sta et
