require_relative "./main"

task default: %w[fetch]

namespace :fetch do
  task :timpul do
    TimpulFetcher.new.run
  end

  task :publika do
    PublikaFetcher.new.run
  end

  task :unimedia do
    UnimediaFetcher.new.run
  end
end

namespace :parse do
  task :timpul do
    TimpulParser.new.run
  end

  task :publika do
    PublikaParser.new.run
  end

  task :unimedia do
    UnimediaParser.new.run
  end
end

