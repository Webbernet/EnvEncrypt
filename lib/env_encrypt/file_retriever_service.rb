class FileRetrieverService
  attr_reader :key, :bucket

  def initialize(key, bucket)
    @key = key
    @bucket = bucket
  end

  def body 
    s3 = Aws::S3::Client.new
    s3.get_object(
      bucket: bucket,
      key: key
    ).body.read
  end
end
