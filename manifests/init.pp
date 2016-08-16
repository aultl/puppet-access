#
# access - init.pp
# 
# class to install the access module

class access inherits access::params {

  include access::install
}
