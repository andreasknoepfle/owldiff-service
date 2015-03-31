#\ -s puma
# Require the necessary init.rb file
require 'app'

set :run, false
set :environment, :production

# deploy httpd server
run Sinatra::Application
