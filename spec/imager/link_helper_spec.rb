require 'spec_helper'

describe Imager::LinkHelper do
  describe ".link_for" do
    it "returns a correct link" do
      Imager.configure do |c|
        c.base_uri = "http://base_uri"
        c.collection_path = "images"
      end

      correct_link = "http://base_uri/images/testcollection/1/image/small.jpg"
      result = described_class.link_for("testcollection", "1", "image", :small)

      result.should eq correct_link
    end
  end
end