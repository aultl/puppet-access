# puppet-access

This puppet module was written to manage the /ec/security/access.conf file on RedHat/CentOS based systems

# usage
access::entry { "vagrant_ssh" : 
  user => 'vagrant', 
  login => true,
  cron => true,
 }
