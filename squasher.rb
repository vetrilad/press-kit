require_relative "main"

class Squasher
  PARSED_DIR   = "data/parsed/unimedia/"
  SQUASHED_DIR = "data/squashed/"

  attr_accessor :data

  def initialize
    @data = []
    File.write(SQUASHED_DIR + "all.json", "")
  end

  def has_mention?(text)
    People.each do |person|
      person.terms.each do |term|
        return true unless text.scan(term).empty?
      end
    end
    false
  end

  def build_url(article)
    "http://unimedia.info/stiri/-#{article["id"]}.html"
  end

  def most_recent
    Dir[PARSED_DIR + "*"].max_by { |f| File.mtime(f) }
  end

  def parsed_time
    File.mtime(most_recent)
  end

  def squashed_time
    File.mtime(SQUASHED_DIR + "all.json")
  end

  def check_timestamps!
    if squashed_time < parsed_time
      # there's nothing new
      puts "Nothing new parsed"
      exit
    end
  end

  def run
    check_timestamps

    Dir[PARSED_DIR + "*"].each do |filename|
      puts "Loading #{filename}"
      article = JSON.parse(File.read(filename))
      id = filename.gsub(PARSED_DIR, "")
      article["id"]  = id
      article["url"] = build_url(article)
      next unless article["content"]

      article["content"] = I18n.transliterate(article["content"])

      if has_mention?(article["content"])
        data << article
      end
    end

    sorted = data.sort_by {|elem| elem["id"].to_i }
    File.write(SQUASHED_DIR + "all.json", JSON.pretty_generate(sorted))
  end
end
