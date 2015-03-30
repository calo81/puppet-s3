# Define a type to copy a directory from S3
define s3::sync($source,$bucket,$owner,$group,$mode,$dest_path) {
  file { $dest_path:
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }
  exec { "fetch ${source}":
    path        => ['/usr/bin/','/usr/sbin/','/usr/local/bin'],
    command     => "aws s3 sync s3://${bucket}/${source} ${dest_path} --recursive",
    environment =>  ['http_proxy=http://proxydirect.tycoelectronics.com:80','https_proxy=http://proxydirect.tycoelectronics.com:80','HTTP_PROXY=http://proxydirect.tycoelectronics.com:80','HTTPS_PROXY=http://proxydirect.tycoelectronics.com:80','no_proxy=169.254.169.254,localhost,127.0.0.1,.tycoelectronics.net,.tycoelectronics.com','NO_PROXY=169.254.169.254,localhost,127.0.0.1,.tycoelectronics.net,.tycoelectronics.com'],
    creates     => "${dest_path}/${source}",
    requires    => File[$dest_path],
  }
}
