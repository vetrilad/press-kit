require 'rest_client'

MOST_RECENT_ID = 75357
PAGES_DIR      = "data/pages/"
PER_SECOND     = 15

def latest_stored_id
  Dir["#{PAGES_DIR}*"].map{ |f| f.gsub(PAGES_DIR, "") }
                      .map(&:to_i)
                      .sort
                      .last
end

def link(id)
  "http://unimedia.info/stiri/-#{id}.html"
end

def save(page, id)
  File.write(PAGES_DIR + id.to_s, page)
end

def time_left_string(id)
  time = (MOST_RECENT_ID - id) / PER_SECOND
  minutes, seconds = time.divmod(60)
  hours, minutes   = minutes.divmod(60)
  "#{hours}h #{minutes}m #{seconds}s"
end

def fetch_single(id)
  page = RestClient.get(link(id))
  bytes = save(page, id)
  puts "#{id} saved. #{bytes/1024} KB"
end

(latest_stored_id..MOST_RECENT_ID).step(PER_SECOND) do |id|
  PER_SECOND.times do |increment|
    fetch_single(id + increment)
  end
  puts (id / MOST_RECENT_ID.to_f * 100).round(2).to_s + "% done"
  puts time_left_string(id)
  puts
end

