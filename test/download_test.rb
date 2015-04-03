require 'test/test_helper'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def test_download_to_tempfile
    url = "http://www.example.com/something.owl"
    path = "test/fixtures/download_file"
    DownloadService.stubs(:open).with(url).returns(File.open(path)) # stub out the request
    file = DownloadService.download_url(url)
    assert_equal Tempfile, file.class # must be a tempfile
    assert file.path # must exist
    assert_equal File.open(path).read, file.read # must contain the test content and be rewinded
  end
end
