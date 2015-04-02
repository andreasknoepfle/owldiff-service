require 'test/test_helper'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    @sample1 = "samples/pizzas.owl"
    @sample2 = "samples/pizza_diff.owl"
    @url1 = "http://test.de/test1.owl"
    @url2 = "http://test.de/test2.owl"
    @sf1 = File.new(@sample1)
    @sf2 = File.new(@sample2)
  end

  def app
    Sinatra::Application
  end

  def test_root_path
    get '/'
    assert last_response.ok?
  end

  def test_diff_path
    DownloadService.expects(:download_url).with(@url1).returns(@sf1)
    DownloadService.expects(:download_url).with(@url2).returns(@sf2)
    get '/diff', owl1_url: @url1, owl2_url: @url2
    assert last_response.ok?
  end

  def test_json_diff
    DownloadService.expects(:download_url).with(@url1).returns(@sf1)
    DownloadService.expects(:download_url).with(@url2).returns(@sf2)
    get '/diff.json', owl1_url: @url1, owl2_url: @url2
    JSON.load last_response.body
  end

end
