# Require the necessary libraries.
require 'rubygems'
require 'sinatra'
#require 'sinatra/reloader'
require "haml"
require 'java'
require 'json'

set :views, 'views'

Dir["models/*.rb"].each { |file| load file }
Dir["services/*.rb"].each { |file| load file }
Dir["helpers/*.rb"].each {|file| load file}


get '/' do
  haml :index
end

get '/diff' do

  @o1 = DownloadService.download_url(params[:owl1_url])
  @o2 = DownloadService.download_url(params[:owl2_url])
  @diff = OntologyDiff.new(@o1.path, @o2.path)

  haml :diff
end
