require 'spec_helper'

describe Imager::ServerInterface do
  describe ".post" do

    context "when params are valid" do
      it "returns true" do
        expect {
          described_class.post("testcollection", "1", "image.jpg", small: { width: 100 })
        }.to be_true
      end
    end

    context "when some param is not correct" do
      it "raises an error" do
        expect {
          described_class.post("", "", "image.jpg", small: { width: 100 })
        }.to raise_error
      end
    end

  end

  describe ".delete" do
    context "valid params and existing image" do
      before {
        described_class.post("testcollection", "1", "spec/image.jpg", small: { width: 100 })
      }

      it "returns true" do
        expect { described_class.delete("testcollection", "1", "image") }.to be_true
      end
    end

    context "some invalid param" do
      it "raises an error" do
        expect {
          described_class.delete("testcollection", "1", "non_existing_image")
        }.to raise_error
      end
    end
  end
end