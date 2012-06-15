#
# Cookbook Name:: ec2-ami-tools
# Recipe:: default
#
# Copyright 2011, trampoline systems ltd
#
# All rights reserved - Do Not Redistribute
#
require 'fileutils'

package "unzip"

remote_file "/tmp/ec2-ami-tools.zip" do
  source "http://s3.amazonaws.com/ec2-downloads/ec2-ami-tools.zip"
end

bash "unzip ec2-ami-tools" do
  cwd "/tmp"
  code <<-EOH
    unzip -o -d /usr/local/share ./ec2-ami-tools.zip
  EOH
  not_if { File.exist?("/usr/local/share/ec2-ami-tools") }
end

# create a soft-link to a known path only if the zipfile extracted
ruby_block "link-ec2-ami-tools" do
  block do
    if Dir["/usr/local/share/ec2-ami-tools-*"].first
      FileUtils.rm_f("/usr/local/share/ec2-ami-tools")
      FileUtils.ln_s(Dir["/usr/local/share/ec2-ami-tools-*"].first, "/usr/local/share/ec2-ami-tools")
    end
  end
end
