require 'aws-sdk'

Aws.config.update({
  region: 'us-west-2',
  credentials: Aws::Credentials.new($sesames["s3"]["access_key_id"], $sesames["s3"]["secret_access_key"])
})
