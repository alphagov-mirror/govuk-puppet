require_relative '../../../../spec_helper'

describe 'govuk_jenkins::package', :type => :class do
  let(:params) {{
    :version             => '1.554.2',
  }}

  let(:pre_condition) {
    class { 'govuk_python::apt_source':
      apt_mirror_hostname => 'apt.example.com',
    }

  # let(:pre_condition) { '@filebeat::prospector {"foo": }' }

  let(:facts) {{
    :jenkins_plugins => 'fake_plugin 1.0'
  }}

  it { is_expected.to contain_class('jenkins').with(
    'version'            => '1.554.2',
    'repo'               => 'false',
    'install_java'       => 'false',
    'configure_firewall' => 'false',
  ) }
end
