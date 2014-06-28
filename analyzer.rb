require_relative "main"

class Analyzer
  def run
    compute_mentions
    dataset = compute_dataset
    puts "Saving data to dataset.json..."
    File.write("dataset.json", dataset.to_json)
  end

  private

  def compute_mentions
    without_mentions = ParsedPage.where(:mentions => nil)
    progressbar = ProgressBar.new(without_mentions.count, :bar, :counter, :rate, :eta)

    puts "Computing mentions..."
    without_mentions.each do |page|
      progressbar.increment!

      page.mentions ||= {}
      People.each do |person|
        page.mentions[person.key] = person.terms.any? {|t| page.content.include?(t) }
      end

      page.total_mentions = page.mentions.values.count(true)
      page.save
    end
  end

  def compute_dataset
    puts "Building the final dataset..."
    data = {}
    progressbar = ProgressBar.new(6 * 12, :bar, :counter, :rate, :eta)

    (2008..2014).each do |year|
      year_data = data[year.to_s] ||= {}

      (1..12).each do |month|
        progressbar.increment!
        month_data = year_data[month.to_s] ||= {}

        pages = ParsedPage.where({
          :datetime.gte => Date.new(year, month, 1),
          :datetime.lte => Date.new(year, month, -1)
        })

        monthly_count = pages.count

        People.each do |person|
          occurences = if monthly_count == 0
            0.0
          else
            total_count = pages.count {|p| p.mentions[person.key.to_s]}
            (total_count / monthly_count).round(2)
          end

          month_data[person.key] = {
            name:       person.name,
            occurences: occurences
          }
        end
      end
    end
  end
end
