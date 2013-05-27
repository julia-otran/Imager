require 'test/unit'
require 'imager'

class ImagerTest < Test::Unit::TestCase
  def test_valid_post_image
    response = Imager::ServerInterface.post("test-collection", "test-album", File.new("test/test_image.jpg"), small: { width: 100})
    assert_equal true, response
  end

  def test_invalid_post_image
    response = Imager::ServerInterface.post("", "", File.new("test/test_image.jpg"), small: { width: 100})
    assert_equal false, response
  end
end