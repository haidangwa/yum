require 'spec_helper'

describe 'yum_test::test_repository_four' do
  let(:test_repository_four_run) do
    ChefSpec::SoloRunner.new(
      step_into: 'yum_repository'
    ).converge(described_recipe)
  end

  let(:test_repository_four_file) do
    test_repository_four_run.file('/etc/yum.repos.d/test4.repo')
  end

  context 'deletes a yum_repository' do
    before do
      allow_any_instance_of(Chef::Recipe).to receive(:yum_cachedir)
        .and_return('/var/cache/yum')
    end

    it 'deletes yum_repository[test4]' do
      expect(test_repository_four_run).to delete_yum_repository('test4')
    end

    it 'deletes file[/etc/yum.repos.d/test4.repo]' do
      expect(test_repository_four_run).to delete_file('/etc/yum.repos.d/test4.repo')
    end

    it 'deletes test4 cache dir' do
      expect(test_repository_four_run).to delete_directory('/var/cache/yum/test4')
        .with(recursive: true)
    end

    it 'does not run ruby_block[yum-cache-reload-test4]' do
      expect(test_repository_four_run).to_not run_ruby_block('yum-cache-reload-test4')
    end

    it 'sends a :create to ruby_block[yum-cache-reload-test4]' do
      expect(test_repository_four_file).to notify('ruby_block[yum-cache-reload-test4]')
    end
  end
end
