require "imager/version"

module Imager

  class << self
    attr_accessor :manager_path, :collection_path, :auth_code, :server_uri

    def configure
      yield self
    end
  end

end
