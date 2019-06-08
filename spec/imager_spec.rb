require 'spec_helper'

describe Imager do
  describe ".configure" do

    it "yields" do
      described_class.configure do |c|
        expect(c).to be described_class
      end
    end

    it "sets server_uri" do
      described_class.configure do |c|
        c.base_uri = "http://baseuri.bla/"
      end

      expect(described_class.base_uri).to eq "http://baseuri.bla/"
    end

    it "sets manager_path" do
      described_class.configure do |c|
        c.manager_path = "manager_path"
      end

      expect(described_class.manager_path).to eq "manager_path"
    end

    it "sets collection_path" do
      described_class.configure do |c|
        c.collection_path = "your_collections_path"
      end

      expect(described_class.collection_path).to eq "your_collections_path"
    end

    it "sets auth_code" do
      described_class.configure do |c|
        c.auth_code = "your_auth_code"
      end

       expect(described_class.auth_code).to eq "your_auth_code"
    end
  end
end