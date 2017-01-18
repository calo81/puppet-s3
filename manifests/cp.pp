# Defining a type for copying a single file from s3
define s3::cp (
  $source,
  $bucket,
  $owner,
  $group,
  $mode,
  $dest_path,
  $environment,
  $s3name = $name,
  $notification = nodef,
){
  exec { "fetch ${name}":
    path        => ['/bin','/sbin','/usr/bin/','/usr/sbin/','/usr/local/bin'],
    command     => "aws s3 cp s3://${bucket}/${source}/${s3name} ${dest_path}",
    environment => $environment,
    creates     => "${dest_path}",
  }->
  file { "/tmp/${dest_path}":
    ensure => 'file',
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }
  
 file { "${dest_path}":
    source => '/tmp/${dest_path}'
    owner  => $owner,
    group  => $group,
    mode   => $mode,
    notify => $notification
  }
}
