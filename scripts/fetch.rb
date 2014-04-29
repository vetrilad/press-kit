require_relative "../main"

UnimediaFetcher.new.run

begin
  tries ||= 200
  TimpulFetcher.new.run
rescue RestClient::BadGateway => e
  sleep 2
  puts "RestClient::BadGateway caught"
  puts "retrying"
  retry unless (tries -= 1).zero?
else
  puts "Done"
end
