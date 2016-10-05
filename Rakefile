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

namespace :watch do
  namespace :timpul do
    task :fetcher do
      while true do
        puts "Restarting Fetcher"
        TimpulFetcher.new.run
        sleep 10
      end
    end

    task :parser do
      while true do
        puts "Restarting parser"
        TimpulParser.new.run
        sleep 10
      end
    end
  end
end
