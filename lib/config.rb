module Rorrent
  def self.config
    {
      url: 'http://torrasave.site/torrent/',
      torrent_location: './torrents',
      file_list_location: './file_lists'
    }
  end
end
