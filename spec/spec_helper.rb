require 'imager'

RSpec.configure do |c|
  c.before do
    Imager.configure do |c|
      c.base_uri        = "http://dev.local/imagerserver/"
      c.auth_code       = ""
      c.collection_path = "manager"
      c.manager_path    = "images"
    end
  end
end