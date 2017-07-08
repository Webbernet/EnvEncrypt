require_relative 'decryptor'
require_relative 'config_map'
require_relative 'encryption_key_fetcher'

class ConfigKeyStore
  attr_reader :config_name

  def initialize(config_name, map, key, bucket)
    @config_name = config_name
    @map      = map
    @key      = key
    @bucket   = bucket
  end

  def fetch
    decrypt_if_needed(fetch_environment_keys(config_name, @map))
  end

  private

  def decrypt_if_needed(config_map)
    if config_map[:encrypted] != nil
      decrypt(config_map[:encrypted])
    elsif config_map[:plain] != nil
      config_map[:plain]
    else
      puts "---WARNING--- Missing '#{config_name}' environment variable"
      ''
    end
  end

  def fetch_environment_keys(config_name, map)
    ConfigMap.new(config_name, map).fetch
  end

  def decrypt(data)
    Decryptor.decrypt_string(
      data,
      encryption_key_information[:key],
      encryption_key_information[:iv]
    )
  end

  def encryption_key_information
    @cached_key ||= EncryptionKeyFetcher.new(@key, @bucket).retrieve
  end
end
