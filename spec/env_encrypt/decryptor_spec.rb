require 'spec_helper'
require 'base64'

RSpec.describe Decryptor do
  subject { described_class }
  let(:plain_string) { 'Thisistheconfidentialdata' }
  it 'can encrypt and decrypt a string' do
    decryption_info = subject.encrypt_string(plain_string, random_base, random_base)
    expect(decrypt_string(decryption_info)).to eq(plain_string)
  end

  def decrypt_string(decryption_info)
    Decryptor.decrypt_string(
      decryption_info[:encrypted],
      decryption_info[:key],
      decryption_info[:iv]
    )
  end

  def random_base
    Base64.encode64('thisisatestpieceoftext')
  end
end
