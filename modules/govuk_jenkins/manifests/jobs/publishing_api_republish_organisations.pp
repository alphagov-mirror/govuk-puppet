# == Class: govuk_jenkins::jobs::publishing_api_republish_organisations
#
# Create a jenkins job to periodically run rake for the following tasks:
# - represent_downstream:high_priority_document_type[:document_type]
#
# === Parameters:
#

class govuk_jenkins::jobs::publishing_api_republish_organisations(
  $app_domain = hiera('app_domain'),
) {

  $check_name = 'publishing-api-republish-organisations'
  $service_description = 'Publishing API - Republish organisations'
  $job_url = "https://deploy.${::aws_environment}.govuk.digital/job/publishing_api_republish_organisations_process/"

  file { '/etc/jenkins_jobs/jobs/publishing_api_republish_organisations.yaml':
    ensure  => present,
    content => template('govuk_jenkins/jobs/publishing_api_republish_organisations.yaml.erb'),
    notify  => Exec['jenkins_jobs_update'],
  }
}
