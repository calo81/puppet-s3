# Defining a type for copying a single file from s3
define s3::cp ($source,$bucket,$owner,$group,$mode,$dest_path) {
  exec { "fetch ${name}":
    path    => ['/usr/bin/','/usr/sbin/','/usr/local/bin'],
    if defined(awscli){
      command     => "aws s3 cp s3://${bucket}/${source}/${name} ${dest_path}/${name}",
      environment =>  ['http_proxy=http://proxydirect.tycoelectronics.com:80','https_proxy=http://proxydirect.tycoelectronics.com:80','HTTP_PROXY=http://proxydirect.tycoelectronics.com:80','HTTPS_PROXY=http://proxydirect.tycoelectronics.com:80','no_proxy=169.254.169.254,localhost,127.0.0.1,.tycoelectronics.net,.tycoelectronics.com','NO_PROXY=169.254.169.254,localhost,127.0.0.1,.tycoelectronics.net,.tycoelectronics.com'],
    else {
      command     => "curl https://s3.amazonaws.com/${bucket}/${source}/${name} -o ${dest_path}/${name}",
      environment =>  ['http_proxy=http://proxydirect.tycoelectronics.com:80','https_proxy=http://proxydirect.tycoelectronics.com:80','HTTP_PROXY=http://proxydirect.tycoelectronics.com:80','HTTPS_PROXY=http://proxydirect.tycoelectronics.com:80','no_proxy=169.254.169.254,localhost,127.0.0.1,.tycoelectronics.net,.tycoelectronics.com','NO_PROXY=169.254.169.254,localhost,127.0.0.1,.tycoelectronics.net,.tycoelectronics.com'],
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
