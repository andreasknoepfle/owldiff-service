ENV['RACK_ENV'] = 'test'

if ENV['CI']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start
end

require 'rack/test'
require 'minitest'
require "minitest/autorun"
require "minitest/pride"
require 'mocha/mini_test'
require 'app'
