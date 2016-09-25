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
