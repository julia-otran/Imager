# Imager

Use with [ImagerServer](https://github.com/guilherme-otran/ImagerServer), a storange and resizer server for images.
Check the test directory for know how the server works.
 You can save your images in other domain running ImagerServer.

[![Build Status](https://travis-ci.org/guilherme-otran/Imager.png?branch=master)](https://travis-ci.org/guilherme-otran/Imager)
[![Dependency Status](https://gemnasium.com/guilherme-otran/Imager.png)](https://gemnasium.com/guilherme-otran/Imager)

## Please contribute!
A lot of the features are not implemented yet (except for the server)

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Installation

Add this line to your application's Gemfile:

    gem 'imager'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install imager

## Usage

    Imager.configure do |c|
      c.base_uri          = "http://files.myserver.com"
      c.manager_path      = "manager"
      c.collections_path  = "images"
      c.auth_code         = ""
    end

  c.auth_code is the `$YOUR_AUTH_CODE = '';` you setted in the [server] (https://github.com/guilherme-otran/ImagerServer).
  This is for post and delete authentication (manager).

### Sending the images

    Imager::ServerInterface.post("Collection", "Album", "test/imageid.png", small: { width: 100 })

  Creates:

    http://files.myserver.com/images/Collection/Album/imageid/small.jpg

  And

    Imager::ServerInterface.post("Collection", "Album", "test/image.png", small: { width: 100 }, "someimageid")

  Creates

    http://files.myserver.com/images/Collection/Album/someimageid/small.jpg

### Removing the images

    Imager::ServerInterface.delete("Collection", "Album", "imageid")

### Using the images

    Imager::LinkHelper.link_for("Collection", "Album", "imageid", :small)

Will return:
    "http://files.myserver.com/images/collection/album/image/small.jpg"
    Since the server ALWAYS save the images as jpg.

You can use Collection as model name(product) and album as id(1) and get the result:

    "http://files.myserver.com/images/product/1/image/small.jpg"
  Just save as:
    `Imager::ServerInterface.post("product", "1", "test/image.png", small: { width: 100 })`

## Notes about saving and sizes
  Saving first as `"product", "1", "test/image.png", small: { width: 100 })` and after `"product", "1", "test/otherimage.png", small: { width: 90 })` don't changes the size of image. Beware!

### Sizes Explain:
  The server accepts the following combinations:

  ```
  YourSizeName: :original       # Will save the original size. Don't worry. The server compress to 50% of quality.
  YourSizeName: { width:  100 } # Will resize (maintein main aspect) the image for 100px of width
  YourSizeName: { height: 100 } # Will resize (maintein main aspect) the image for 100px of height
  YourSizeName: { width:  100, height: 150 } # Will resize to fit in 100x150 px
  ```

  You can have many sizes when posting a image:

  ```
  sizes = {
    small:     { width:  100 },
    gallery:   { height: 300 },
    mini-home: { width: 50, height: 50 },
    original:  :original
  }
  ```

### Compression
  The images always are compressed to 70%. Except for the original size (50%).
