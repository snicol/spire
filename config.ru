$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'rack'
require 'spire'

run Spire::Router.new('./app', {
  "default" => "index#index", # the default route!
  "/index" => "index#index",
})