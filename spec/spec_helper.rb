require 'imager'

#dependencies
require 'minitest/autorun'
require 'webmock/rspec'
require 'vcr'
require 'turn'
require "rack/test"

RSpec.configure do |c|
  c.before do
    Imager.configure do |c|
      c.base_uri        = "http://localhost/imagerserver"
      c.auth_code       = "ABCDE"
      c.collection_path = "images"
      c.manager_path    = "manager"
    end
  end
end

Turn.config do |c|
 # :outline  - turn's original case/test outline mode [default]
 c.format  = :outline
 # turn on invoke/execute tracing, enable full backtrace
 c.trace   = true
 # use humanized test names (works only with :outline format)
 c.natural = true
end

#VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/imagerserver_cassettes'
  c.hook_into :webmock
end