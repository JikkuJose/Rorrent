require 'open-uri'

info_hashes = STDIN.read.split

def url(info_hash)
  "http://torrasave.site/torrent/#{info_hash}.torrent"
end

def already_downloaded?(info_hash)
  File.file?("./torrents/#{info_hash}.torrent")
end

info_hashes.each do |ih|
  unless already_downloaded?(ih)
    print '.'

    open(url(ih)) do |f|
      File.open("./torrents/#{ih}.torrent", 'w') do |torrent|
        torrent.write(f.read)
      end
    end
  end
end
