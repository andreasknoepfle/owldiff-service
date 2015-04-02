# Require the necessary libraries.
require 'rubygems'
require 'sinatra'
require "haml"
require 'java'
require 'json'
require 'lib/owl2vcs.jar'

unless settings.production?
  require 'sinatra/reloader'
  require 'pry'
end

set :views, 'views'
set :bind, '0.0.0.0'

Dir["models/*.rb"].each { |file| load file }
Dir["services/*.rb"].each { |file| load file }
Dir["helpers/*.rb"].each {|file| load file}


def download_and_diff
  @o1 = DownloadService.download_url(params[:owl1_url])
  @o2 = DownloadService.download_url(params[:owl2_url])
  @diff = OntologyDiffService.new(@o1.path, @o2.path).diff
end

get '/' do
  haml :index
end

get '/diff' do
  download_and_diff
  haml :diff
end

get '/diff.json' do
  download_and_diff
  @diff.to_json
end
