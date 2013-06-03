require 'spec_helper'

describe Imager::ServerInterface do
  describe ".post" do

    context "when params are valid" do
      it "returns true" do
        VCR.use_cassette('valid_post') do
          described_class.post("test", "1", "spec/image.jpg", small: { width: 100 }).should be_true
        end
      end
    end

    context "when no image" do
      it "raises an error" do
        # No request made here, because has no image
        expect {
          described_class.post("", "", "", size: { width: 100 })
        }.to raise_error Imager::ImagerError
      end
    end

    context "when other params are wrong" do
      it "raises an error" do
        VCR.use_cassette('invalid_album_and_collection_post') do
          expect {
            described_class.post("", "", "spec/image.jpg", size: { width: 100 })
          }.to raise_error Imager::ImagerError
        end
      end
    end
  end

  describe ".delete" do
    context "valid params and existing image" do

      it "returns true" do
        VCR.use_cassette('valid_post') do
          described_class.post("test", "1", "spec/image.jpg", small: { width: 100 })
        end
        VCR.use_cassette('valid_delete') do
          described_class.delete("test", "1", "image").should be_true
        end
      end
    end

    context "some invalid param" do
      it "raises an error" do
        VCR.use_cassette('no_image_delete') do
          expect {
            described_class.delete("test", "1", "non_existing_image")
          }.to raise_error Imager::ImagerError
        end
      end
    end
  end
end