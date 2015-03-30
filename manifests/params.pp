# Parameters for s3 function
class s3::params {
  $bucket       = undef
  $source       = undef
  $dest_path    = '/tmp'
  $owner        = 'root'
  $group        = 'root'
  $mode         = '0644'
  $environment  = undef
  case $::osfamily {
    'RedHat': {
      $awscli_path = '/usr/bin/aws'
    }
    'Debian' : {
      $awscli_path = '/usr/local/bin/aws'
    }
  }
}
