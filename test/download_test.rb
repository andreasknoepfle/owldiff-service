require 'test/test_helper'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def test_download_to_tempfile
    url = "http://gitlab.com/something.owl"
    path = "test/fixtures/download_file"
    DownloadService.any_instance.stubs(:open).with(url,{:read_timeout => 10}).returns(File.open(path)) # stub out the request
    file = DownloadService.new(valid_settings).download_url(url)
    assert_equal Tempfile, file.class # must be a tempfile
    assert file.path # must exist
    assert_equal File.open(path).read, file.read # must contain the test content and be rewinded
  end

  def test_unknown_host
    url = "http://www.example.com/something.owl"
    assert_raises Exception do
      DownloadService.new(valid_settings).download_url(url)
    end
  end

  def test_unknown_host
    url = "http://gitlab.com/something.bar"
    assert_raises Exception do
      DownloadService.new(valid_settings).download_url(url)
    end
  end

  private

  def valid_settings
    {
      "timeout" => 10,
      "allowed_hosts" => ["gitlab.com","localhost"],
      "allowed_extensions" => [".ttl",".owl",".rdf"]
    }
  end

end
