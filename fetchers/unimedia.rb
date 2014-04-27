require 'rest_client'
require 'nokogiri'
require 'pry'


class Fetcher
  PAGES_DIR = "./data/pages/unimedia/"
  FEED_URL  = "http://unimedia.info/rss/news.xml"

  def setup
    FileUtils.mkdir_p PAGES_DIR
  end

  def most_recent_id
    return @most_recent_id if @most_recent_id
    doc = Nokogiri::XML(RestClient.get(FEED_URL))
    @most_recent_id = doc.css("link")[3].text.scan(/-([\d]+)\.html.+/).first.first.to_i
  end

  def latest_stored_id
    Dir["#{PAGES_DIR}*"].map{ |f| f.gsub(PAGES_DIR, "") }
                        .map(&:to_i)
                        .sort
                        .last || 0
  end

  def link(id)
    "http://unimedia.info/stiri/-#{id}.html"
  end

  def save(page, id)
    File.write(PAGES_DIR + id.to_s, page)
  end

  def time_left_string(id)
    time = (most_recent_id - id) / 3 #magical number
    minutes, seconds = time.divmod(60)
    hours, minutes   = minutes.divmod(60)
    "#{hours}h #{minutes}m #{seconds}s"
  end

  def fetch_single(id)
    page = RestClient.get(link(id))
    bytes = save(page, id)
    puts "#{id} saved. #{bytes/1024} KB"
  end

  def run
    setup

    p "Latest stored id is #{latest_stored_id}"
    p "Most recent id is #{most_recent_id}"

    latest_stored_id.upto(most_recent_id) do |id|
      fetch_single(id)
      puts (id / most_recent_id.to_f * 100).round(2).to_s + "% done"
      puts time_left_string(id)
      puts
    end
  end
end


Fetcher.new.run

