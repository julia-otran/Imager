require "imager/version"
require "imager/server_client"
require "imager/server_interface"

module Imager

  class << self
    attr_accessor :manager_path, :collection_path, :auth_code, :base_uri

    def configure
      yield self
    end
  end

end
