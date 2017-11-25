require 'spec_helper'

RSpec.describe EncryptionKeyFetcher do
  let(:key)    { 'thisisakey' }
  let(:bucket) { 'thisisabucket' }
  let(:encryption_json) { "{ \"hello\":\"hello\" }" }
  subject { described_class.new(key, bucket).retrieve }

  before do
    allow(S3FileService).to receive(:new)
      .and_return(double(body: encryption_json))
  end

  it "retrieves a hash" do
    expect(subject).to be_instance_of(Hash)
  end

  it "calls the file retriever service correctly" do
    expect(S3FileService).to receive(:new)
                                      .with(key, bucket)
    subject
    
  end
end
