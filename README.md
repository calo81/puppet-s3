##WIP##
Function:
This module is used to pull files from AWS S3 locations using the aws ruby SDK, aws cli, or curl mechanisms. It supports both single file and recursive directory sync. It also allows you to manage the files pulled from S3 with common parameters of the Puppet file resource, such as owner, group and mode.

Usage:
 In the desired manifest, add 
include s3

Then declare resources:
Single file:
s3::cp { 'name of file to be copied':   <---- presently this command only supports naming the file locally with the same                                                         filename as exists on S3.
  bucket    => 's3 bucket location, in format s3://bucket_name',
  source    => 'path after bucket in s3',
  dest_path => 'path the file should be copied to locally',
  owner     => 'owner_name',
  group     => 'group_name',
  mode      => 'mode',
  }
  
Recursive Directory:
s3::sync { 'name of directory to sync "equiv to $source above"':
  bucket    => 's3 bucket location, in format s3://bucket_name',
  dest_path => 'top level location to sync directories, should be parent dir of $source/$namevar',
  owner     =>  'owner_name',
  group     => 'group_name',
  mode      => 'mode',
  }
  
