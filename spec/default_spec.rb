require 'chefspec'

describe 'chef-ec2-ami-tools::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-ec2-ami-tools::default' }

  it "installs unzip" do
    chef_run.should install_package 'unzip'
  end

  it "downloads ec2-ami-tools.zip" do
    chef_run.should create_remote_file '/tmp/ec2-ami-tools.zip'
  end
end
