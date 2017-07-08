require "env_encrypt/version"
require 'env_encrypt/config_key_store'

class EnvEncrypt
  def initialize(map = {}, bucket, key_name)
    @map      = map
    @bucket   = bucket
    @key_name = key_name
  end

  def fetch(key)
    ConfigKeyStore.new(key, @map, @key_name, @bucket)
  end
end
