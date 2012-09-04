class govuk_node::frontend_server inherits govuk_node::base {

  include govuk_node::ruby_app_server

  include govuk::apps::planner
  include govuk::apps::datainsight_frontend
  include govuk::apps::tariff
  include govuk::apps::efg
  include govuk::apps::calendars
  include govuk::apps::smartanswers
  include govuk::apps::feedback
  include govuk::apps::designprinciples
  include govuk::apps::licencefinder
  include govuk::apps::publicapi
  include govuk::apps::frontend
  include govuk::apps::search

  include nginx

  # WIP, transitioning static to unicorn but don't want changes to go to production yet
  # -- ppotter, 2012-09-05
  case $::govuk_platform {
    production: {
      class { 'apache2':
        port => '8080'
      }
      class { 'passenger':
        maxpoolsize => 12
      }

      apache2::vhost::passenger {
        "static.${::govuk_platform}.alphagov.co.uk":;
      }

      nginx::config::vhost::static { "static.$::govuk_platform.alphagov.co.uk":
        protected => false,
        aliases   => ['calendars', 'planner', 'smartanswers', 'static', 'frontend', 'designprinciples', 'licencefinder', 'tariff', 'efg', 'feedback'],
        ssl_only  => true
      }
    }
    default: {
      include govuk::apps::static
    }
  }
}
