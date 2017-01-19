# Defining a type for copying a single file from s3
define s3::cp (
  $source,
  $bucket,
  $owner,
  $group,
  $mode,
  $dest_path,
  $s3name = $name,
  $notification = nodef,
){
  exec { "fetch ${name}":
    path        => ['/bin','/sbin','/usr/bin/','/usr/sbin/','/usr/local/bin'],
    command     => "aws s3 sync s3://${bucket}/${source}/ /tmp${dest_path} --exclude '*' --include '$s3name'",
    logoutput   => true,
  }->
  file { "/tmp${dest_path}/${s3name}":
    ensure => 'file',
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }->
  
 file { "${dest_path}":
    source => "/tmp${dest_path}/${s3name}",
    owner  => $owner,
    group  => $group,
    mode   => $mode,
    notify => $notification
  }
}
