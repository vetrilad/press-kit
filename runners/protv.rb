module Runners
  class ProTV < BaseRunner
    attr_reader :fetcher, :name

    def initialize(fetcher: Fetchers::ProTV.new)
      @fetcher = fetcher
      @name = "ProTV"
    end

    def reverse_run
      puts "Fetching #{name} Most recent: #{fetcher.most_recent_id}. Last fetched: "
      #
      # if latest_stored_id == fetcher.most_recent_id
      #   puts "Nothing to fetch for Timpul"
      #   return
      # end

      array = []
      (126991..848541).step(10) do |id|
        array << id
      end
      
      array.reverse_each do |id|
          fetcher.fetch_single(id)
          progressbar.increment!
      end
    end

  end
end
