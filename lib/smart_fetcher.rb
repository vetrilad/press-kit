# A fetcher that knows how to fetch links properly
class SmartFetcher
  def self.fetch url
    RestClient.get url
  rescue Errno::ETIMEDOUT => e
    sleep 2
    puts "timeout: #{url}"
    retry
  rescue Errno::ECONNREFUSED => e
    sleep 30
    puts "refused: #{url}"
    retry
  rescue RestClient::BadGateway => error
    sleep 2
    puts "bad gateway: #{url}"
    retry
  end
end
