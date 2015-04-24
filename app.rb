# Require the necessary libraries.
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/config_file'
require 'haml'
require 'java'
require 'json'
require 'lib/owl2vcs.jar'
require 'owldiff'

unless settings.production?
  require 'sinatra/reloader'
  require 'pry'
end

config_file 'config/application.yml'

Dir["services/*.rb"].each { |file| load file }
Dir["helpers/*.rb"].each {|file| load file}

set :views, 'views'

def download_and_diff
  @ds = DownloadService.new(settings.download)
  @o1 = @ds.download_url(params[:owl1_url])
  @o2 = @ds.download_url(params[:owl2_url])
  @diff = OntologyDiffService.new(@o1.path, @o2.path).diff
rescue Exception => e
  handle_exception e
end

def handle_exception e
  @diff = {error: e.message} # produce a json response in case
  @error = e.message
end

get '/' do
  haml :index
end

get '/diff'  do
  download_and_diff
  halt haml(:index) if @error
  haml :diff
end

get '/diff.json' do
  download_and_diff
  status 422 if @error # unprecessible entry
  @diff.to_json
end
