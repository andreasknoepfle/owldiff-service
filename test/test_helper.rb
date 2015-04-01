ENV['RACK_ENV'] = 'test'

require 'simplecov'

SimpleCov.start

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'minitest'
require "minitest/autorun"
require "minitest/pride"
require 'rack/test'


require_relative '../app.rb'
