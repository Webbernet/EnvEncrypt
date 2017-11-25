require 'json'
require_relative 's3_file_service'

class EncryptionKeyFetcher
  def initialize(key, bucket)
    @key = key
    @bucket = bucket
  end

  def retrieve
    decryption_info
  end

  def decryption_info
    JSON.parse(raw_file, symbolize_names: true)
  end

  def raw_file
    S3FileService.new(@key, @bucket).body
  end
end
