require 'test/unit'
require 'imager'

class ImagerTest < Test::Unit::TestCase

  def test_configure
    Imager.configure do |c|
      assert_equal c, Imager
    end
  end

  def test_set_server_uri
    Imager.configure do |c|
      c.server_uri = "http://localhost/imager_server"
    end

    assert_equal "http://localhost/imager_server", Imager.server_uri
  end

  def test_set_manager_path
    Imager.configure do |c|
      c.manager_path = "manager"
    end

    assert_equal "manager", Imager.manager_path
  end

  def test_set_collection_path
    Imager.configure do |c|
      c.collection_path = "images"
    end

    assert_equal "images", Imager.collection_path
  end

  def test_set_auth_code
    Imager.configure do |c|
      c.auth_code = "123456789ABCDE"
    end

    assert_equal "123456789ABCDE", Imager.auth_code
  end

  def test_valid_post_image
    response = Imager::ServerInterface.post("testcollection", "1", File.new("test/test_image.jpg"), small: { width: 100})
    assert_equal true, response
  end

  def test_invalid_post_image
    response = Imager::ServerInterface.post("", "", File.new("test/test_image.jpg"), small: { width: 100})
    assert_equal false, response
  end
end