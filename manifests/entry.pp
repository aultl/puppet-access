# Handles access concerns.  
#
# Les Ault <les.ault@jtv.com>
#
# PURPOSE: Manages files in the /etc/security/access.d dirctory
#          and executes a rebuild-access script to build
#          a fully baked access policy 
#
# USAGE:
# If you want to allow johnsmith to login, call this function like so:
#
# access::entry { 'that_dude' :
#   user  => 'johnsmith', 
#   login => true,
#   cron  => true,
# }
#
  
define access::entry (
  $user,
  $login = false,
  $cron  = false,
){
  include access 

  if (($login) and ($cron)) {
    $content = inline_template("<%= '+:' + @user + ':ALL\n+:' + @user + ': cron crond' %>")   
  } elsif (($login) and (! $cron)) {
    $content = inline_template("<%= '+:' + @user + ':ALL' %>")
  } else {
    $content = inline_template("<%= '+:' + @user + ': cron crond' %>")   
  }
  
  file { "/etc/security/access.d/$name":
    ensure  => present,
    content => "${content}",
    require => File['/etc/security/access.d'],
    notify  => Exec['rebuild_access'],
  }

  validate_bool($login)
  validate_bool($cron)
}
