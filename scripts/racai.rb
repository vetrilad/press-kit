require_relative '../main'

BATCH_SIZE = 10
DELAY = 10

total = ParsedPage.count
without = ParsedPage.without_words.count
progressbar = ProgressBar.new(without, :bar, :counter, :rate, :eta)

progressbar.increment!(0)
loop do
  articles = ParsedPage.pick_without_words(BATCH_SIZE)
  BatchRacaiFetcher.process!(articles)
  progressbar.increment!(articles.count)
  sleep DELAY
  break if articles.count < BATCH_SIZE
end