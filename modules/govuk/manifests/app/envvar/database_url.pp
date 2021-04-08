# == Define: govuk::app::envvar::database_url
#
# Defines a DATABASE_URL env var for an app. This constructs the URL from the
# given parameters, taking care of escaping the password.
#
# === Parameters
#
# [*type*]
#   The database type. This becomes the scheme in the database URL.
#
# [*username*]
#   The database username.
#
# [*password*]
#   The database password.  This value will be escaped before being inserted in
#   the URL.
#
# [*host*]
#   The hostname of the database server.
#
# [*database*]
#   The database name.
#
# [*port*]
#   The database port.  If not given, no port is included in the URL.
#
define govuk::app::envvar::database_url (
  $type,
  $username,
  $password,
  $host,
  $database,
  $port = undef,
) {

  if $port == undef {
    $host_and_port = $host
  } else {
    $host_and_port = "${host}:${port}"
  }

  $escaped_password = inline_template('<%= CGI.escape(@password.to_s) %>')
  govuk::app::envvar { "${title}-DATABASE_URL":
    app     => $title,
    varname => 'DATABASE_URL',
    value   => "${type}://${username}:${escaped_password}@${host_and_port}/${database}",
  }
}
