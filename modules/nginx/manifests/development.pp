class nginx::development {
  include nginx
  file { '/etc/nginx/sites-enabled/default':
    ensure  => file,
    source  => 'puppet:///modules/nginx/development',
    require => Class['nginx::install'],
    notify  => Exec['nginx_reload'],
  }

}
