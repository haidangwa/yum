require 'spec_helper'

describe 'yum::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'installed python' do
    expect(chef_run).to install_package('python')
  end

  it 'creates yum_globalconfig[/etc/yum.conf]' do
    expect(chef_run).to create_yum_globalconfig('/etc/yum.conf')
  end
end
