module Runners
  class Publika < BaseRunner
    attr_reader :fetcher, :name

    def initialize(fetcher: PublikaFetcher.new)
      @fetcher = fetcher
      @name = "Publika"
    end

    def reverse_run
      puts "Fetching #{name} Most recent: #{fetcher.most_recent_id}. Last fetched: #{latest_stored_id}."
      #
      # if latest_stored_id == fetcher.most_recent_id
      #   puts "Nothing to fetch for Timpul"
      #   return
      # end

      array = []
      (latest_stored_id..fetcher.most_recent_id).step(10) do |id|
        array << id
      end
      
      array.reverse_each do |id|
        fetcher.fetch_single(id)
        progressbar.increment!
      end
    end
  end
end
