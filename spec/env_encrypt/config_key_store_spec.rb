require 'spec_helper'

RSpec.describe ConfigKeyStore do
  let(:key_name) { 'TestKey' }
  let(:all_keys) { {} }
  let(:key)      { 'thisisakey' }
  let(:bucket)   { 'thisisabucket' }
  let(:map)      { { encrypted: nil, plain: 'test' } }
  subject { described_class.new(key_name, all_keys, key, bucket).fetch }

  before do
    allow(ConfigMap).to receive(:new)
      .and_return(double(fetch: map))
  end

  it 'calls the config map with the key' do
    expect(ConfigMap).to receive(:new).with(key_name)
                                              .and_return(double(fetch: map))
    subject
  end

  context 'if the encrypted key exists' do
    let(:map) { { encrypted: '123', plain: nil } }
    let(:key) { 'This-is-the-secret-key' }
    let(:iv)  { 'This-is-the-iv' }
    let(:decrypted) { 'BouncyCastle' }
    let(:encryption_map) { {key: key, iv: iv} }

    before do
      allow(EncryptionKeyFetcher).to receive(:new)
        .and_return(double(retrieve: encryption_map))
      allow(Decryptor).to receive(:decrypt_string)
        .and_return(decrypted)
    end

    it 'calls the decrypt function' do
      expect(Decryptor).to receive(:decrypt_string)
        .with('123', key, iv).and_return(decrypted)
      subject
    end

    it 'returns the decrypted string' do
      expect(subject).to eq(decrypted)
    end
  end

  context 'if the plaintext key exists' do
    let(:map) { { encrypted: nil, plain: password } }
    let(:password) { 'Castle' }
    it 'returns the plaintext key' do
      expect(subject).to eq(password)
    end
  end
end
