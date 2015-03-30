# Defining a type for copying a single file from s3
define s3::cp (
  $source      = $s3::params::source,
  $bucket      = $s3::params::bucket,
  $owner       = $s3::params::owner,
  $group       = $s3::params::group,
  $mode        = $s3::params::mode,
  $dest_path   = $s3::params::dest_path,
  $environment = $s3::params::environment,
)inherits s3::params {
  exec { "fetch ${name}":
    path    => ['/bin','/sbin','/usr/bin/','/usr/sbin/','/usr/local/bin'],
    if $::awscli_version(defined) {
      command     => "aws s3 cp s3://${bucket}/${source}/${name} ${dest_path}/${name}",
      environment => $environment, 
    else {
      command     => "curl https://s3.amazonaws.com/${bucket}/${source}/${name} -o ${dest_path}/${name}",
      environment => $environment,
    }
  }
    creates => "${dest_path}/${name}",
  }->
  file { "${dest_path}/${name}":
    ensure => 'file',
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }
}
