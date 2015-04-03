AWS.config(region: 'us-east-1')
S3_BUCKET = AWS::S3.new.buckets['mass-spec-test-bucket']