require "spec_helper"

RSpec.describe EnvEncrypt do
  subject { described_class.new(map, bucket, key_name) }
  let(:fetch)        { subject.fetch(config_name) }
  let(:map)          { 'testmap' }
  let(:config_name)  { 'dbpassword' }
  let(:bucket)       { 'bucket!' }
  let(:key_name)     { 'key!' }
  
  it "has a version number" do
    expect(EnvEncrypt::VERSION).not_to be nil
  end

  it "calls the config store with the correct params" do
    expect(ConfigKeyStore).to receive(:new).with(
      config_name, map, key_name, bucket
    )
    fetch
  end
end
