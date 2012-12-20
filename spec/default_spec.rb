require 'chefspec'

describe 'ec2-ami-tools::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'my_new_cookbook::default' }

  it "this cookbook needs some TDD love" do
    pending "Add some tests, bro."
  end
end
