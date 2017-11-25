require "bundler/setup"
require_relative "../lib/env_encrypt"
require_relative "../lib/env_encrypt/config_map"
require_relative "../lib/env_encrypt/encryption_key_fetcher"
require_relative "../lib/env_encrypt/s3_file_service"
require_relative "../lib/env_encrypt/decryptor"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
