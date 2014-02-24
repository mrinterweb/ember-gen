
module EmberGen
  module Support
    module FileSupport
      require 'json'
      require 'open-uri'

      def parse_name(path)
        path.match(%r~.*[/](?<name>.+)$~)[:name]
      end

      def grab_json(url)
        begin
          JSON.parse(download(url).read)
        rescue
          puts "There was a problem fetching y'r JSON"
        end
      end

      def download(url)
        begin
          puts "Downloading: #{url}"
          tmp_file = open(url)
          puts "downloaded #{tmp_file.size / 1024}KB"
          tmp_file
        rescue OpenURI::HTTPError
          puts "Download failed: #{url}"
        end
      end

      def download_and_move(url, destination)
        tmp_file = download(url)
        File.rename tmp_file, destination
      end

      def github_url_to_raw(url)
        url.sub("https://", "https://raw2.").sub('blob/', '')
      end
    end

  end
end
