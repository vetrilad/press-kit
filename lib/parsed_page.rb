class ParsedPage
  include Mongoid::Document

  store_in collection: "parsed_pages"

  field :source,        :type => String
  field :title,         :type => String
  field :original_time, :type => String
  field :datetime,      :type => Time
  field :views,         :type => Integer
  field :comments,      :type => Integer
  field :content,       :type => String
  field :article_id,    :type => Integer
  field :url,           :type => String
end
