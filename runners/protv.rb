module Runners
  class ProTV
    attr_reader :fetcher, name

    def initialize(fetcher)
      @fetcher = fetcher
      @name = "ProTV"
    end

    def latest_stored_id
      Dir["#{fetcher.page_dir}*"].map { |f| f.split('.').first.gsub(fetcher.page_dir, "") }
          .map(&:to_i)
          .sort
          .last || 1
    end
  end
end