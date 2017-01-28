require 'bencode'

require_relative './downloader.rb'
require_relative './config.rb'

module Rorrent
  class Extractor
    attr_reader :info_hash

    def initialize(info_hash:)
      @info_hash = info_hash
    end

    def files
      if valid?
      parsed["info"]["files"]
        .map { |f| f["path"] }
      else
        STDERR.puts "Invalid torrent file: #{info_hash}"
        []
      end
    end

    def parsed
      @parsed ||= BEncode::Parser
        .new(torrent)
        .parse!
    end

    def valid?
      !!parsed
    end

    def torrent
      download
      File.open(torrent_file, 'r') { |f| f.read }
    end

    def download
      Downloader
        .new(info_hash: info_hash)
        .download
    end

    def torrent_file
      "#{Rorrent::config[:torrent_location]}/#{info_hash}.torrent"
    end
  end
end
