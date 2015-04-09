
Warbler::Config.new do |config|
config.dirs = %w(helpers models public services views config tmp lib)
 config.includes = FileList["app.rb"]
 config.bundle_without = ["test", "development"]
 config.gem_dependencies = true
end
