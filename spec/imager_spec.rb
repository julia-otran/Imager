require 'spec_helper'

describe Imager do
  describe ".configure" do

    it "yields" do
      described_class.configure do |c|
        c.should be described_class
      end
    end

    it "sets server_uri" do
      described_class.configure do |c|
        c.base_uri = "http://baseuri.bla/"
      end

      described_class.base_uri.should eq "http://baseuri.bla/"
    end

    it "sets manager_path" do
      described_class.configure do |c|
        c.manager_path = "manager_path"
      end

      described_class.manager_path.should eq "manager_path"
    end

    it "sets collection_path" do
      described_class.configure do |c|
        c.collection_path = "your_collections_path"
      end

      described_class.collection_path.should eq "your_collections_path"
    end

    it "sets auth_code" do
      described_class.configure do |c|
        c.auth_code = "your_auth_code"
      end

       described_class.auth_code.should eq "your_auth_code"
    end
  end
end