# FIXME: This class needs better documentation as per https://docs.puppetlabs.com/guides/style_guide.html#puppet-doc
class elasticsearch_old::package (
  $version = undef,
) {

  if $version == undef {
    fail('You must provide an elasticsearch version for package installation')
  }

  package { 'elasticsearch':
    ensure => $version,
    notify => Exec['disable-default-elasticsearch'],
  }

  # Disable the default elasticsearch setup, as we'll be installing an upstart
  # job to manage elasticsearch in elasticsearch_old::{config,service}
  exec { 'disable-default-elasticsearch':
    onlyif      => '/usr/bin/test -f /etc/init.d/elasticsearch',
    command     => '/etc/init.d/elasticsearch stop && /bin/rm -f /etc/init.d/elasticsearch && /usr/sbin/update-rc.d elasticsearch remove',
    refreshonly => true,
  }

  # Manage elasticsearch plugins, which are installed by elasticsearch_old::plugin
  file { '/usr/share/elasticsearch/plugins':
    ensure  => directory,
    purge   => true,
    recurse => true,
    force   => true,
    require => Package['elasticsearch'],
  }

  file { '/var/run/elasticsearch':
    ensure => directory,
  }

  file { '/var/log/elasticsearch':
    ensure  => directory,
    owner   => 'elasticsearch',
    group   => 'elasticsearch',
    require => Package['elasticsearch'], # need to wait for package to create ES user.
  }
}
