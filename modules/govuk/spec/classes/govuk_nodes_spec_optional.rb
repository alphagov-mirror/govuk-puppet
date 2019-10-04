require 'tempfile'
require 'yaml'

require_relative '../../../../spec_helper'

# This spec test has been renamed so as not to be caught by the default
# `rake spec` task. It is called explicitly by `rake spec:nodes`. Tag
# filtering was not appropriate because the glob and loop below get
# eagerly evaluated.

def temporary_hiera_file_for(hiera_yml_name)
  standard_hiera_config = YAML.load_file(
    File.expand_path("../../../../../#{hiera_yml_name}", __FILE__)
  )

  standard_hiera_config[:yaml][:datadir] = 'hieradata'
  standard_hiera_config[:eyaml][:datadir] = 'hieradata'
  standard_hiera_config[:eyaml][:gpg_gnupghome] = 'gpg'

  temporary_hiera_file = Tempfile.new('hiera_yml')
  temporary_hiera_file.write(standard_hiera_config.to_yaml)
  temporary_hiera_file.close

  temporary_hiera_file.path
end

carrenza_hieradata_file_path = temporary_hiera_file_for('hiera.yml')
aws_hieradata_file_path = temporary_hiera_file_for('hiera_aws.yml')

excluded_classes_for_carrenza = [
  "content_data_api_db_admin",
]

excluded_classes_for_aws = [
  "email_alert_api_postgresql",
]

ENV.fetch('classes').split(",").each do |class_name|
  node_hostname = class_name.tr("_", "-")

  describe "govuk::node::s_#{class_name}", :type => :class do
    let(:node) { "#{node_hostname}-1.example.com" }
    let(:facts) do
      {
        :environment => (class_name =~ /^development$/ ? "development" : 'vagrant'),
        :concat_basedir => '/var/lib/puppet/concat/',
        :kernel => 'Linux',
        :memorysize =>  '3.86 GB',
        :memorysize_mb => 3953.43,
        :aws_migration => (class_name =~ /db_admin/ ? true : false),
        :vdc => 'example',
      }
    end

    # Pull in some required bits from top-level site.pp
    let(:pre_condition) do
      <<-EOT
        $govuk_node_class = "#{class_name}"

        $lv = hiera('lv',{})
        create_resources('govuk_lvm', $lv)
        $mount = hiera('mount',{})
        create_resources('govuk_mount', $mount)
      EOT
    end

    unless excluded_classes_for_carrenza.include? class_name
      context 'in Carrenza' do
        let(:hiera_config) { carrenza_hieradata_file_path }

        it "should compile" do
          expect { subject.call }.not_to raise_error
        end
      end
    end

    unless excluded_classes_for_aws.include? class_name
      context 'in AWS' do
        let(:hiera_config) { aws_hieradata_file_path }

        it "should compile" do
          expect { subject.call }.not_to raise_error
        end
      end
    end
  end
end
