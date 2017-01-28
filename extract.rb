require 'bencode'

filename = ARGV[0]

torrent = File.open(filename, 'r') { |f| f.read }

data = BEncode::Parser
  .new(torrent)
  .parse!

puts data["info"]["files"].map { |f| f["path"] }
