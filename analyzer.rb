require_relative "main"

class Analyzer
  SQUASHED_DIR = "data/squashed/"

  attr_accessor :data, :result

  def initialize
    @data, @result = JSON.parse(File.read(SQUASHED_DIR + "all.json")), {}
  end

  def run
    puts "Replacing the timestamps..."
    data.each do |item|
      item["time"] = DateTime.parse(item["datetime"])
    end

    (2008..2014).each do |year|
      year_filtered = data.select { |e| e["time"].year == year }
      result[year.to_s] = {}

      (1..12).each do |month|
        month_filtered = year_filtered.select { |e| e["time"].month == month }
        puts "Working with #{month}.#{year}"

        full_text   = month_filtered.map { |e| e["content"] }.join(" ")
        month_data  = {}
        month_total = month_filtered.count
        People.each do |person|
          total_occurences = 0

          month_filtered.each do |article|
            if person.terms.any? { |term| article["content"].scan(term).count > 0 }
              total_occurences += 1
            end
          end

          occurences = if month_total.zero?
            0.0
          else
            (total_occurences.to_f / month_total).round(2)
          end

          month_data[person.key] = {
            name: person.name,
            occurences: occurences
          }
        end

        result[year.to_s][month.to_s] = month_data
      end
    end


    File.write("dataset.json", result.to_json)
  end
end
