
Warbler::Config.new do |config|
config.dirs = %w(helpers models public services views config tmp lib)
 config.includes = FileList["app.rb"]
 config.gems += ["sinatra","haml","puma"]
 config.gems -= ["rails"]
 config.gem_dependencies = true
end
