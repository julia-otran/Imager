module Imager
  class LinkHelper
    # @param  [String]         Collection for save the image
    # @param  [String]         Album for save the image
    # @param  [String]         File id
    # @param  [Symbol, String] Image Size name.
    def self.link_for(collection, album, image, size)
      size = size.to_s
      "#{Imager.base_uri}/#{Imager.collection_path}/#{collection}/#{album}/#{image}/#{size}.jpg"
    end
  end
end