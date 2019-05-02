# == Class: govuk_search::docker
#
# Installs and configures Docker and Docker Compose
class govuk_search::docker_elasticsearch {

  $docker_directory = '/usr/share/docker/elasticsearch'
  $compose_path = "${docker_directory}/docker-compose.yml"

  file { $docker_directory:
    ensure => directory,
  } ->

  file { "${docker_directory}/config.yml":
    ensure  => file,
    source => 'puppet:///modules/govuk_search/elasticsearch.yml',
  } ->

  file { "${docker_directory}/Dockerfile":
    ensure  => file,
    source => 'puppet:///modules/govuk_search/Dockerfile',
  } ->

  file { $compose_path:
    ensure => file,
    source => 'puppet:///modules/govuk_search/docker-compose.yml',
  }

  include ::govuk_docker

  class { '::docker::compose':
    ensure  => present,
    version => '1.7.0',
  }

  docker_compose { $compose_path:
    ensure  => present,
    require => File[$compose_path],
  }

}
