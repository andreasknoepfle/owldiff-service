ENV['RACK_ENV'] = 'test'

require 'simplecov'

SimpleCov.start

require 'minitest'
require "minitest/autorun"
require "minitest/pride"
require 'rack/test'


require_relative '../app.rb'
