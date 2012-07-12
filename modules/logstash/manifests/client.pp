class logstash::client {
  class { 'logstash::client::config':
    before => Class['logstash::client::package']
  }
  class { 'logstash::client::package': }
  class { 'logstash::client::service':
    subscribe => Class['logstash::client::package']
  }
}
