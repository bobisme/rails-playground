class AwsController < ApplicationController
  def signed_redirect
    client = Aws::S3::Client.new(region: 'us-east-1')
    # default expiration is 15 minutes
    signer = Aws::S3::Presigner.new(client: client)
    url = signer.presigned_url(
      :get_object, bucket: 'lrbob-sandbox', key: 'this-is-private.txt'
    )
    redirect_to url, status: :temporary_redirect
  end
end
