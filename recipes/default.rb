#
# Cookbook Name:: ec2-ami-tools
# Recipe:: default
#
# Copyright 2011, trampoline systems ltd
# Copyright 2012, Blackstone Technology Group
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

require 'fileutils'

package "unzip"

install_root = node["chef-ec2-ami-tools"]["install_root"]
install_target = "#{install_root}/ec2-ami-tools"

remote_file "/tmp/ec2-ami-tools.zip" do
  source "http://s3.amazonaws.com/ec2-downloads/ec2-ami-tools.zip"
end

bash "unzip ec2-ami-tools" do
  cwd "/tmp"
  code <<-EOH
    unzip -o -d #{install_root} ./ec2-ami-tools.zip
  EOH
  not_if { File.exist?(install_target) }
end

# create a soft-link to a known path only if the zipfile extracted
ruby_block "link-ec2-ami-tools" do
  block do
    if Dir["#{install_target}-*"].first
      FileUtils.rm_f(install_target)
      FileUtils.ln_s(Dir["#{install_target}-*"].first, install_target)
    end
  end
end
