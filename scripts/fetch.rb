require_relative "../main"

UnimediaFetcher.new.run

begin
  TimpulFetcher.new.run
rescue => e
  binding.pry
end
