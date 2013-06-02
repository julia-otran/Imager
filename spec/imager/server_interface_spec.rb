require 'spec_helper'
require 'debugger'
describe Imager::ServerInterface do
  describe ".post" do

    context "when params are valid" do
      it "returns true" do
        described_class.post("test", "1", "spec/image.jpg", small: { width: 100 }).should be_true
      end
    end

    context "when some param is not correct" do
      it "raises an error" do
        expect {
          described_class.post("", "", "", size: { width: 100 })
        }.to raise_error
      end
    end

  end

  describe ".delete" do
    context "valid params and existing image" do

      it "returns true" do
        described_class.post("test", "1", "spec/image.jpg", small: { width: 100 })
        described_class.delete("test", "1", "image").should be_true
      end
    end

    context "some invalid param" do
      it "raises an error" do
        expect {
          described_class.delete("test", "1", "non_existing_image")
        }.to raise_error
      end
    end
  end
end