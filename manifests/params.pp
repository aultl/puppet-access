#
# access - params.pp
#

class access::params {

  case $::operatingsystem {
      /RedHat|CentOS/: {
        $access_config     = '/etc/security/access.conf'
        $pam_sshd_config   = '/etc/pam.d/sshd'
        $file_mode         = '0644'
        $file_owner        = 'root'
        $file_group        = 'root'
     }

      default: {
        fail('The ${module_name} module is not supported on an ${::osfamily} based system.')
      }
  }
}
