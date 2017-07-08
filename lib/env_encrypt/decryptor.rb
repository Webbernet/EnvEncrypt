require 'base64'
require 'openssl'

class Decryptor
  def self.decrypt_string(base64_encrypted_data, base64_key, base64_iv)
    encrypted = decode_from_64(base64_encrypted_data)
    decipher  = cbc_cipher
    decipher.decrypt
    decipher.key = decode_from_64(base64_key)
    decipher.iv  = decode_from_64(base64_iv)
    decipher.update(encrypted) + decipher.final
  end

  def self.encrypt_string(string_to_encrypt, key = nil, iv = nil)
    cipher = cbc_cipher
    cipher.encrypt
    key = decode_from_64(key)
    cipher.key = key
    iv = decode_from_64(iv)
    cipher.iv = iv

    ### Uncomment these lines if you want to generate
    ### a key and iv instead of passing it in.
    # key = cipher.random_key
    # iv  = cipher.random_iv
    encrypted = cipher.update(string_to_encrypt) + cipher.final
    output_decryption_information(key, iv, encrypted)
  end

  def self.encode_to_64(string)
    Base64.encode64(string)
  end

  def self.decode_from_64(string)
    Base64.decode64(string)
  end

  def self.cbc_cipher
    OpenSSL::Cipher::AES.new(128, :CBC)
  end

  def self.output_decryption_information(key, iv, encrypted)
    {
      key:       encode_to_64(key),
      iv:        encode_to_64(iv),
      encrypted: encode_to_64(encrypted)
    }
  end
end
