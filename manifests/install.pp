# Class to install the AWS CLI or AWS SDK
class s3::install (
  $install_tools = $s3::params::install_tools,
  $proxy_url     = $s3::params::proxy_url,
  $proxy_user    = $s3::params::proxy_user,
  $proxy_pass    = $s3::params::proxy_pass,
  $awscli_path   = $s3::params::awscli_path,
)inherits s3::params{
  if $proxy_url != undef {
    Package <| provider == 'gem' |> {
      install_options => {
        '--http-proxy' => $proxy_url,
      }
    }
  }
  case $install_tools {
    true :  {
      if ! defined(Package['aws-sdk']) {
        package { 'aws-sdk':
          ensure   => 'latest',
          provider => 'gem',
        }
      }
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
        exec { 'awscli w-proxy':
          path    => ['/usr/bin','/usr/sbin','/bin','/sbin','/usr/local/bin'],
          command => "pip --proxy ${proxy_url} install awscli",
          creates => $awscli_path,
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
