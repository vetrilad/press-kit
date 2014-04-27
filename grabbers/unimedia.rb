require 'rest_client'
require 'nokogiri'
require 'pry'

PAGES_DIR       = "./data/pages/unimedia/"
FileUtils.mkdir_p "./data/pages/unimedia"


def most_recent_id
  return @most_recent_id if @most_recent_id
  url = "http://unimedia.info/rss/news.xml"

  doc = Nokogiri::XML(RestClient.get(url))
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

p "Latest stored id is #{latest_stored_id}"
p "Most recent id is #{most_recent_id}"

(latest_stored_id..most_recent_id).step(1) do |id|
  fetch_single(id)
  puts (id / most_recent_id.to_f * 100).round(2).to_s + "% done"
  puts time_left_string(id)
  puts
end

