require 'open-uri'

class DownloadService
  def self.download_url url
    file = Tempfile.new('ontology')
    file << open(url).read
    file
  end
end
