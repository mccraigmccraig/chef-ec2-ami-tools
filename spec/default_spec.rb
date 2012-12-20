require 'chefspec'

describe 'chef-ec2-ami-tools::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-ec2-ami-tools::default' }

  it "installs unzip" do
    chef_run.should install_package 'unzip'
  end
end
