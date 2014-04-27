require 'rest_client'
require 'nokogiri'
require 'progress_bar'
require 'pry'

class Fetcher
  PAGES_DIR  = "./data/pages/timpul/"
  TITTER_URL = "https://twitter.com/Timpul"

  def setup
    FileUtils.mkdir_p PAGES_DIR
  end

  def most_recent_id
    return @most_recent_id if @most_recent_id
    doc = Nokogiri::XML(RestClient.get(TITTER_URL))
    @most_recent_id = doc.css(".tweet-text")
                         .text
                         .scan(/timpul.md\/u_[\d]+\//)
                         .first
                         .scan(/\d+/)
                         .first
                         .to_i
  end

  def latest_stored_id
    Dir["#{PAGES_DIR}*"].map{ |f| f.gsub(PAGES_DIR, "") }
                        .map(&:to_i)
                        .sort
                        .last || 0
  end

  def link(id)
    "http://www.timpul.md/u_#{id}/"
  end

  def save(page, id)
    File.write(PAGES_DIR + id.to_s, page)
  end

  def fetch_single(id)
    page = RestClient.get(link(id))
    save(page, id)
  end

  def progressbar
    @progressbar ||= ProgressBar.new(most_recent_id - latest_stored_id, :bar, :counter, :rate, :eta)
  end

  def run
    setup
    puts "Fetching Timpul. Most recent: #{most_recent_id}. Last fetched: #{latest_stored_id}."

    latest_stored_id.upto(most_recent_id) do |id|
      fetch_single(id)
      progressbar.increment!
    end
  end
end

begin
  Fetcher.new.run
rescue => e
  binding.pry
end
