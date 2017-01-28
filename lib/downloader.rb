require_relative './config.rb'
require 'open-uri'

module Rorrent
  class Downloader
    attr_reader :info_hash

    def initialize(info_hash:)
      @info_hash = info_hash
    end

    def download
      unless already_downloaded?
        print '.'

        open(url) do |f|
          File.open(torrent_file, 'w') do |torrent|
            torrent.write(f.read)
          end
        end
      end
    end

    private

    def url
      "#{Rorrent::config[:url]}#{info_hash}.torrent"
    end

    def torrent_file
      "#{Rorrent::config[:torrent_location]}/#{info_hash}.torrent"
    end

    def already_downloaded?
      File.file?(torrent_file)
    end
  end
end
