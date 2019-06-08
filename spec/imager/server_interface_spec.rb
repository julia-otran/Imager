require 'spec_helper'

describe Imager::ServerInterface do
  let(:some_image){ "spec/image.jpg" }
  let(:some_image_file) { File.new(some_image) }
  let(:some_image_io)   { Rack::Test::UploadedFile.new(some_image_file, "application/octet-stream") }
  describe ".post" do

    context "when params are valid" do
      it "returns true" do
        VCR.use_cassette('valid_post') do
          expect(described_class.post("test", "1", some_image, small: { width: 100 })).to be_truthy
        end
      end

      context "when image is a file" do
        it "returns true" do
          VCR.use_cassette('valid_post_with_file') do
            expect(described_class.post("test", "1", some_image_file, small: { width: 100 })).to be_truthy
          end
        end
      end

      context "when image is a IO" do
        it "returns true" do
          VCR.use_cassette('valid_post_with_io') do
            expect(described_class.post("test", "1", some_image_io, small: { width: 100 })).to be_truthy
          end
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
            described_class.post("", "", some_image, size: { width: 100 })
          }.to raise_error Imager::ImagerError
        end
      end
    end
  end

  describe ".delete" do
    context "valid params and existing image" do

      it "returns true" do
        VCR.use_cassette('valid_post') do
          described_class.post("test", "1", some_image, small: { width: 100 })
        end
        VCR.use_cassette('valid_delete') do
          expect(described_class.delete("test", "1", "image")).to be_truthy
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