require_relative "../main"

class PublikaFetcher
  attr_accessor :page_dir
  FEED_URL = "http://rss.publika.md/stiri.xml"

  def initialize
    @page_dir = "data/pages/publika/"
    setup
  end

  def setup
    FileUtils.mkdir_p page_dir
  end

  def most_recent_id
    return @most_recent_id if @most_recent_id
    doc = Nokogiri::XML(RestClient.get(FEED_URL))
    @most_recent_id = doc.css("link")[2]
                          .text
                          .scan(/_([\d]+)\.html/)
                          .first
                          .first
                          .to_i
  end

  def latest_stored_id
    Dir["#{page_dir}*"].map { |f| f.split('.').first.gsub(page_dir, "") }
        .map(&:to_i)
        .sort
        .last || 0
  end

  def link(id)
    "http://publika.md/#{id}"
  end

  def valid?(page)
    !page.nil? && page.include?("publicat in data de")
  end

  def save(page, id)
    Zlib::GzipWriter.open(page_dir + id.to_s + ".html.gz") do |gz|
      gz.write page
    end
  end

  def fetch_single(id)
    page = SmartFetcher.fetch(link(id))
    save(page, id) if valid?(page)
  end

  def progressbar
    @progressbar ||= ProgressBar.new(most_recent_id - latest_stored_id, :bar, :counter, :rate, :eta)
  end

  def run
    setup
    puts "Fetching Publika. Most recent: #{most_recent_id}. Last fetched: #{latest_stored_id}."

    if latest_stored_id == most_recent_id
      puts "Nothing to fetch for Publika"
      return
    end

    (latest_stored_id..most_recent_id).step(10) do |id|
      fetch_single(id)
      progressbar.increment!
    end
  end
end
