# EnvEncrypt

EnvEncrypt is an internal tool that we use to pass environment variables to our Ruby projects. We can pass in sensitive variables that are encrypted using a set of keys from S3.

## Installation

### Rails

Add it to your gemfile.

```ruby
gem 'env_encrypt'
```

## Usage in Rails

In `application.rb` of your rails project, you can call the EnvEncrypt service and pass the environment map.

```ruby
# all of the environment variables you want to use
MAP = [
  { name: 'database_key', key: 'ENVIRONMENT_VARIABLE_THE_KEY_IS_IN' }
]

# init the service, passing the bucket and key of the decryption keys in S3
encrypted_store = EnvEncrypt.new(MAP, 'bucket-of-key', 'keyname')

# and then we can add it to Rails configuration state so our code can access it
config.database_key = encrypted_store.fetch('database_host')

```
