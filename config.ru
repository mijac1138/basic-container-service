require "roda"
require "rack/unreloader"

Rack::Unreloader.new.require("./app.rb") { "App" }

run App.freeze.app