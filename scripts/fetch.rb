require_relative "../main"

UnimediaFetcher.new.run

begin
  tries ||= 200
  TimpulFetcher.new.run
rescue RestClient::BadGateway => e
  sleep 2
  puts "ne zaebisi posoni(("
  puts "no zaebisi ne daleko!"
  retry unless (tries -= 1).zero?
else
  puts "zaebisi posoni!!"
end
