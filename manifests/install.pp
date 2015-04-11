# Class to install the AWS CLI or AWS SDK
class s3::install inherits s3{
  case $install_tools {
    true :  {
      if ! defined(Package['python']) {
        package { 'python':
          ensure => 'installed',
        }
      }
      if ! defined(Package['python-pip']) {
        package { 'python-pip':
          ensure => 'installed',
        }
      }
      if $proxy_url != undef {
       if $proxy_pass != undef {
         exec { 'awscli w-proxy':
           path    => ['/usr/bin','/usr/sbin','/bin','/sbin','/usr/local/bin'],
           command => "pip --proxy ${proxy_user}:${proxy_pass}@${proxy_url} install awscli",
           creates => $awscli_path,
         }
       }
      else {
        exec { 'awscli w-proxy':
          path    => ['/usr/bin','/usr/sbin','/bin','/sbin','/usr/local/bin'],
          command => "pip --proxy ${proxy_url} install awscli",
          creates => $awscli_path,
        }
      }
      }
      else {
        if ! defined(Package['awscli']) {
          package { 'awscli':
            ensure   => 'latest',
            provider => 'pip',
          }
        }
      }
    }
    false : { }
  default : { }
  }
}
