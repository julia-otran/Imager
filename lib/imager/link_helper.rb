module Imager
  class LinkHelper
    def self.link_for(collection, album, image, size)
      size = size.to_s
      "#{Imager.base_uri}#{Imager.collection_path}/#{collection}/#{album}/#{image}/#{size}.jpg"
    end
  end
end