require 'chefspec'

describe 'chef-ec2-ami-tools::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-ec2-ami-tools::default' }

  it "installs unzip" do
    chef_run.should install_package 'unzip'
  end

  it "downloads ec2-ami-tools.zip" do
    chef_run.should create_remote_file '/tmp/ec2-ami-tools.zip'
  end

  it "sets the EC2_HOME environment variable" do
    install_target = chef_run.node['chef-ec2-ami-tools']['install_target']
    chef_run.should create_file_with_content '/etc/profile.d/ec2-ami-tools.sh',
                                             %Q{export EC2_HOME=#{install_target}\nexport PATH=$PATH:#{install_target}/bin\n}
    chef_run.file('/etc/profile.d/ec2-ami-tools.sh').should be_owned_by('root', 'root')
  end
end
