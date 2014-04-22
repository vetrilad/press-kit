require 'json'

PARSED_DIR   = "data/parsed/"
SQUASHED_DIR = "data/squashed/"

data = []

File.write(SQUASHED_DIR + "all.json", "")

def build_url(id)
  "http://unimedia.info/stiri/-#{id}.html"
end

Dir[PARSED_DIR + "*"].each do |filename|
  puts "Loading #{filename}"
  article = JSON.parse(File.read(filename))
  id = filename.gsub(PARSED_DIR, "")
  article["id"]  = id
  article["url"] = build_url(id)

  data << article if article["content"]
end

sorted = data.sort_by {|elem| elem["id"].to_i }
File.write(SQUASHED_DIR + "all.json", JSON.pretty_generate(sorted))
