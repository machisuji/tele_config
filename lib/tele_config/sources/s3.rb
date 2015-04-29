require 'aws-sdk'

module TeleConfig
  module Sources
    class S3 < TeleConfig::Source
      param :access_key_id
      param :secret_access_key
      param :region # AWS region

      param :bucket # S3 bucket name
      param :path # path to file in bucket

      def read
        resp = client.get_object(bucket: bucket, key: path)

        resp.body.read
      end

      def client
        Aws::S3::Client.new region: region, credentials: credentials
      end

      def credentials
        Aws::Credentials.new(access_key_id, secret_access_key)
      end
    end
  end
end
