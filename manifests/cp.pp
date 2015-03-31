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
){
  exec { "fetch ${name}":
    path    => ['/bin','/sbin','/usr/bin/','/usr/sbin/','/usr/local/bin'],
    if ${::awscli_version} != undef {
      command     => "aws s3 cp s3://${bucket}/${source}/${s3name} ${dest_path}/${name}",
      environment => $environment, 
    }
    else {
      command     => "curl https://s3.amazonaws.com/${bucket}/${source}/${s3name} -o ${dest_path}/${name}",
      environment => $environment,
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
