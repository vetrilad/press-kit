require_relative '../main'

class BatchRacaiFetcher
  def self.process!(articles)
    result = RacaiBuilder.new(articles)
        .to_sgml
        .tokenize
        .tag
        .lemmatize
        .chunk
        .to_utf8
        .build
    save!(result)
  end

private
  def self.save!(result)
    result.each do |page, result|
      result.split(/\n/).each do |racai_string|
        split_string = racai_string.split(/\t/)
        # it's for because the racai result represent 4 elements separated by \t
        if split_string.count == 4
          Word.save_racai_word!(split_string, page)
        end
      end
      page.has_words = true
      page.save
    end
  end
end