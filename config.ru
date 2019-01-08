require "roda"
require "rack/unreloader"
require 'dotenv/load'

Rack::Unreloader.new.require("./app.rb") { "App" }

run App.freeze.app