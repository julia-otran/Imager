require 'test/unit'
require 'imager'


class ImagerTest < Test::Unit::TestCase
  def your_base_uri;         "http://localhost/projects/imager_server"; end;
  def your_manager_path;     "manager"; end;
  def your_collections_path; "images"; end;
  def your_auth_code;        ""; end;

  def test_configure
    Imager.configure do |c|
      assert_equal c, Imager
    end
  end

  def test_set_server_uri
    Imager.configure do |c|
      c.base_uri = your_base_uri
    end

    assert_equal your_base_uri, Imager.base_uri
  end

  def test_set_manager_path
    Imager.configure do |c|
      c.manager_path = your_manager_path
    end

    assert_equal your_manager_path, Imager.manager_path
  end

  def test_set_collection_path
    Imager.configure do |c|
      c.collection_path = your_collections_path
    end

    assert_equal your_collections_path, Imager.collection_path
  end

  def test_set_auth_code
    Imager.configure do |c|
      c.auth_code = your_auth_code
    end

    assert_equal your_auth_code, Imager.auth_code
  end

  def test_valid_post_image
    Imager.configure do |c|
      c.base_uri = your_base_uri
      c.auth_code = your_auth_code
      c.collection_path = your_collections_path
      c.manager_path = your_manager_path
    end

    response = Imager::ServerInterface.post("testcollection", "1", "test/image.jpg", small: { width: 100 })
    assert_equal true, response
  end

  def test_invalid_post_image
    response = true
    begin
      Imager.configure do |c|
        c.base_uri = your_base_uri
        c.auth_code = your_auth_code
        c.collection_path = your_collections_path
        c.manager_path = your_manager_path
      end
      Imager::ServerInterface.post("", "", "test/image.jpg", small: { width: 100 })
    rescue
      response = false
    end
    assert_equal false, response
  end

  def test_valid_delete_image
    Imager.configure do |c|
      c.base_uri = your_base_uri
      c.auth_code = your_auth_code
      c.collection_path = your_collections_path
      c.manager_path = your_manager_path
    end

    response = Imager::ServerInterface.delete("testcollection", "1", "image")
    assert_equal true, response
  end

  def test_invalid_delete_image
    response = true
    begin
      Imager.configure do |c|
        c.base_uri = your_base_uri
        c.auth_code = your_auth_code
        c.collection_path = your_collections_path
        c.manager_path = your_manager_path
      end
      Imager::ServerInterface.delete("testcollection", "1", "non_existing_image")
    rescue
      response = false
    end
    assert_equal false, response
  end

  def test_link_helper
      Imager.configure do |c|
        c.base_uri = your_base_uri
        c.auth_code = your_auth_code
        c.collection_path = your_collections_path
        c.manager_path = your_manager_path
      end

      result = Imager::LinkHelper.link_for("testcollection", "1", "image", :small)
      should_be = "#{your_base_uri}#{your_collections_path}/testcollection/1/image/small.jpg"

      assert_equal should_be, result
  end
end