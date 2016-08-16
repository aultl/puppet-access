# install.pp - setup the files needed to manage /etc/security/access.conf
class access::install inherits access {
  # run script to rebuild the access.conf file
  exec { "rebuild_access":
    command     => "/usr/sbin/rebuild-access",
    require     => File["/usr/sbin/rebuild-access"],
    refreshonly => true,
  }

  # make sure sshd honors access.conf
  file { 'pam_sshd_config':
    name    => $access::params::pam_sshd_config,
    ensure  => file,
    mode    => $access::params::file_mode,
    owner   => $access::params::file_owner,
    group   => $access::params::file_group,
    source  => "puppet:///modules/${module_name}/sshd",
  }

  # ensure rebuild script is on the server
  file { "/usr/sbin/rebuild-access":
    ensure => file,
    mode   => 755,
    source => "puppet:///modules/access/rebuild-access",
  }

  # make sure directory exists
  file { "/etc/security/access.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
    force   => true,
    source  => "puppet:///modules/${module_name}/empty",
  }
}

