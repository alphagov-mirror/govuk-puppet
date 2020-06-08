# == Class: monitoring::checks::pingdom
#
# Nagios alerts for Pingdom checks.
#
# === Parameters:
#
# [*enable*]
#   Can be used to disable checks/alerts for a given environment. Because
#   the URLs for the checks are configured at Pingdom's side, it is not
#   desirable to have more than one environment send an alert for the same
#   thing.
#
class monitoring::checks::pingdom (
  $enable = true,
) {

  icinga::check_config::pingdom {
    'homepage':
      check_id => 489558;
    'calendar':
      check_id => 489561;
    'quick_answer':
      check_id => 662431;
    'search':
      check_id => 662465;
    'smart_answer':
      check_id => 489560;
    'mirror_S3':
      check_id => 2777110;
    'mirror_S3_replica':
      check_id => 5291414;
  }

  if $enable {
    icinga::check { 'check_pingdom':
      ensure              => 'absent',
      check_command       => 'run_pingdom_homepage_check',
      use                 => 'govuk_urgent_priority',
      host_name           => $::fqdn,
      service_description => 'Pingdom homepage check',
      notes_url           => monitoring_docs_url(pingdom-homepage-check),
    }

    icinga::check { 'check_pingdom_calendar':
      ensure              => 'absent',
      check_command       => 'run_pingdom_calendar_check',
      use                 => 'govuk_high_priority',
      host_name           => $::fqdn,
      service_description => 'Pingdom calendar check',
    }

    icinga::check { 'check_pingdom_search':
      ensure              => 'absent',
      check_command       => 'run_pingdom_search_check',
      use                 => 'govuk_urgent_priority',
      host_name           => $::fqdn,
      service_description => 'Pingdom search check',
      notes_url           => monitoring_docs_url(pingdom-search-check),
    }

    icinga::check { 'check_pingdom_smart_answer':
      ensure              => 'absent',
      check_command       => 'run_pingdom_smart_answer_check',
      use                 => 'govuk_high_priority',
      host_name           => $::fqdn,
      service_description => 'Pingdom smartanswers check',
    }

    icinga::check { 'check_pingdom_mirror_S3':
      ensure              => 'absent',
      check_command       => 'run_pingdom_mirror_S3_check',
      use                 => 'govuk_high_priority',
      host_name           => $::fqdn,
      service_description => 'Pingdom mirror S3 check',
      notes_url           => monitoring_docs_url(pingdom-mirror-check),
    }

    icinga::check { 'check_pingdom_mirror_S3_replica':
      ensure              => 'absent',
      check_command       => 'run_pingdom_mirror_S3_replica_check',
      use                 => 'govuk_high_priority',
      host_name           => $::fqdn,
      service_description => 'Pingdom mirror S3 replica check',
      notes_url           => monitoring_docs_url(pingdom-mirror-check),
    }
  }
}
