# Define a type to copy a directory from S3
define s3::sync($source,$bucket,$owner,$group,$mode,$dest_path) {
  if ! defined(File[$dest_path]){
    file { $dest_path:
      ensure => 'directory',
      owner  => $owner,
      group  => $group,
      mode   => $mode,
    }
  }
  exec { "fetch ${source}":
    path        => ['/usr/bin/','/usr/sbin/','/usr/local/bin'],
    command     => "aws s3 sync s3://${bucket}/${source} ${dest_path}",
    creates     => "${dest_path}/${source}",
    requires    => File[$dest_path],
  }
}
