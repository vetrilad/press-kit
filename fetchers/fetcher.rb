class Fetcher
  def initialize
    @name = :default
    @link = "some default link"
    @feed_url = "something"
    yield self
  end

  def fetch_single(id)
    page = SmartFetcher.fetch(link(id))
    save(page, id) if valid?(page)
  rescue RestClient::ResourceNotFound => error
    puts "not found: #{link(id)}"
  end

  def progressbar
    @progressbar ||= ProgressBar.new(most_recent_id - latest_stored_id, :bar, :counter, :rate, :eta)
  end

  def run
    setup
    puts "Fetching Unimedia. Most recent: #{most_recent_id}. Last fetched: #{latest_stored_id}."

    if latest_stored_id == most_recent_id
      puts "Nothing to fetch for Unimedia"
      return
    end

    latest_stored_id.upto(most_recent_id) do |id|
      fetch_single(id)
      progressbar.increment!
    end
  end

end