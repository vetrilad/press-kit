module Runners
  class BaseRunner
    def progressbar
      @progressbar ||= ProgressBar.new(fetcher.most_recent_id - 126991, :bar, :counter, :rate, :eta)
    end

    def latest_stored_id
      Dir["#{fetcher.page_dir}*"].map { |f| f.split('.').first.gsub(fetcher.page_dir, "") }
          .map(&:to_i)
          .sort
          .last || 1
    end

    def run
      puts "Fetching #{name} Most recent: #{most_recent_id}. Last fetched: #{latest_stored_id}."

      if latest_stored_id == most_recent_id
        puts "Nothing to fetch for Timpul"
        return
      end

      (latest_stored_id..most_recent_id).step(10) do |id|
        fetcher.fetch_single(id)
        progressbar.increment!
      end
    end
  end
end
