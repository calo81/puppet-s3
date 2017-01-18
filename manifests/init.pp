# base class for s3 define types
class s3 (
  $source        = $s3::params::source,
  $bucket        = $s3::params::bucket,
  $owner         = $s3::params::owner,
  $group         = $s3::params::group,
  $mode          = $s3::params::mode,
  $dest_path     = $s3::params::dest_path,
  $proxy_url     = $s3::params::proxy_url,
  $proxy_user    = $s3::params::proxy_user,
  $proxy_pass    = $s3::params::proxy_pass,
  $awscli_path   = $s3::params::awscli_path,
)inherits s3::params{
}
