# base class for s3 define types
class s3 (
  $source        = $s3::params::source,
  $bucket        = $s3::params::bucket,
  $owner         = $s3::params::owner,
  $group         = $s3::params::group,
  $mode          = $s3::params::mode,
  $dest_path     = $s3::params::dest_path,
  $install_tools = $s3::params::install_tools,
)inherits s3::params{
  if $install_tools == true {
    include 's3::install'
  }
}
