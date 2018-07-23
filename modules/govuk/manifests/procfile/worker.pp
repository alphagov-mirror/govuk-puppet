# == Define: govuk::procfile::worker
#
# Creates an upstart entry for a worker as defined by the application's Procfile.
#
# === Parameters
#
# [*enable_service*]
#   Whether or not to start the service.  Always false if $ensure is 'absent'.
#   Default: true
#
# [*ensure*]
#   Whether to create or remove the configuration file.
#   Default: present
#
# [*process_type*]
#   The type of process to spawn, defined in the application's Procfile.
#   This variable is used by the govuk/procfile-worker_child.conf.erb template.
#   Default: 'worker'
#
# [*setenv_as*]
#   The application name to use when calling `govuk_setenv`.
#   This variable is used by the govuk/procfile-worker_child.conf.erb template.
#   Default: $title
#
# [*process_count*]
#   The number of instances to run of this procfile worker.
#   This variable is used by the govuk/procfile-worker.conf.erb template.
#   Default: 1
#
# [*alert_when_threads_exceed*]
#   If set, alert using Icinga if the number of threads exceeds the value specified.
#   Default: 50
#
define govuk::procfile::worker (
  $enable_service = true,
  $ensure = present,
  $process_type = 'worker',
  $setenv_as = $title,
  $process_count = 1,
  $alert_when_threads_exceed = 50,
) {
  validate_re($ensure, '^(present|absent)$', '$ensure must be "present" or "absent"')

  include govuk::procfile

  $service_name = "${title}-procfile-worker"
  $title_underscore = regsubst($title, '\.', '_', 'G')

  collectd::plugin::process { "app-worker-${title_underscore}":
    ensure => $ensure,
    regex  => "sidekiq .* ${title}.*\\.gov\\.uk",
  }

  if $ensure == present {
    file { "/etc/init/${service_name}.conf":
      ensure    => present,
      content   => template('govuk/procfile-worker.conf.erb'),
      notify    => Service[$service_name],
      subscribe => Class['Govuk::Procfile'],
    }

    file { "/etc/init/${service_name}_child.conf":
      ensure    => present,
      content   => template('govuk/procfile-worker_child.conf.erb'),
      notify    => Service[$service_name],
      subscribe => Class['Govuk::Procfile'],
    }

    service { $service_name:
      ensure => $enable_service,
    }

    if $enable_service {
      include icinga::client::check_procfile_workers
      @@icinga::check { "check_app_${title}_procfile_workers_count_${::hostname}":
        check_command       => "check_nrpe!check_procfile_workers!${service_name} ${process_count}",
        service_description => "${title} procfile worker upstart up",
        host_name           => $::fqdn,
        notes_url           => monitoring_docs_url(check-process-running),
      }

      if $alert_when_threads_exceed {
        @@icinga::check::graphite { "check_app_${title}_procfile_worker_thread_count_${::hostname}":
          target    => "${::hostname}.processes-app-worker-${title_underscore}.ps_count.threads",
          warning   => $alert_when_threads_exceed,
          critical  => $alert_when_threads_exceed,
          desc      => "Thread count for ${title_underscore} exceeds ${alert_when_threads_exceed}",
          host_name => $::fqdn,
        }
      }
    }
  } else {
    exec { "stop_service_${service_name}":
      command => "service ${service_name} stop",
      onlyif  => "service ${service_name} status | grep running",
    }

    file { "/etc/init/${service_name}.conf":
      ensure  => absent,
      require => Exec["stop_service_${service_name}"],
    }

    file { "/etc/init/${service_name}_child.conf":
      ensure  => absent,
      require => Exec["stop_service_${service_name}"],
    }
  }
}
