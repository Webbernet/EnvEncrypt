class ConfigMap

  def initialize(key_name, map)
    @key_name = key_name
    @map      = map
  end

  def fetch
    environment_hash(find_element_by_key[:key])
  end

  private

  attr_reader :key_name

  def find_element_by_key
    map_entry = @map.find { |m| m[:name] == key_name }
    raise "Key cannot be found in the Config::ConfigMap - '#{key_name}'" unless map_entry
    map_entry
  end

  def environment_hash(key)
    {
      encrypted: env_variable(encrypted_key_name(key)),
      plain:     env_variable(key)
    }
  end

  def encrypted_key_name(key)
    "ENC_#{key}"
  end

  def env_variable(name)
    Config::EnvironmentVariableFetcher.fetch(name)
  end
end
