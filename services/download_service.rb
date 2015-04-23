require 'uri'
require 'open-uri'

class DownloadService

  def initialize settings
    @settings = settings
  end

  def download_url url
    check_url url
    file = Tempfile.new('ontology')
    file << open(url, read_timeout: @settings["timeout"]).read
    file.rewind
    file
  rescue Exception => e
    raise Exception.new("The file download from #{url} returned an error. #{e.message}")
  end

  private

  def check_url url
    uri = URI.parse url
    check_host uri.host unless ENV["NO_HOST_CHECK"]
    check_extension uri.path
  end

  def check_host host
    unless @settings["allowed_hosts"].include? host
      raise Exception.new("Host \"#{host}\" not in allowed hosts.")
    end
  end

  def check_extension path
    extension = File.extname(path)
    unless @settings["allowed_extensions"].include? extension
      raise Exception.new("File extension \"#{extension}\" not allowed.")
    end
  end

end
