require_relative "main"

class Squasher
  SQUASHED_DIR = "data/squashed/"

  attr_accessor :data

  def initialize
    FileUtils.mkdir_p SQUASHED_DIR
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

  def check_timestamps!
    latest_parsed = ParsedPage.find.sort(:_id : -1).limit(1)
    squashed_time = File.mtime(SQUASHED_DIR + "all.json")

    if squashed_time < latest_parsed.datetime
      # there's nothing new
      puts "Nothing new parsed"
      exit
    end
  end

  def run
    check_timestamps!

    ParsedPage.find.each do |article|
      next unless article.content

      content = I18n.transliterate article.content

      if has_mention?(content)
        data << article
      end
    end

    sorted = data.sort_by {|elem| elem["id"].to_i }
    File.write(SQUASHED_DIR + "all.json", JSON.pretty_generate(sorted))
  end
end
