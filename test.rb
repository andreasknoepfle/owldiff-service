$:<<'test'  # add to load path
files = Dir.glob('test/**/*_test.rb')
files.each{|file| require file}
