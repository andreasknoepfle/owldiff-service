
Warbler::Config.new do |config|
config.dirs = %w(app config tmp lib)
 config.includes = FileList["app.rb"]
 config.gems += ["sinatra","haml"]
 config.gems -= ["rails"]
 config.gem_dependencies = true
end