class ParsedPage
  include Mongoid::Document

  store_in collection: "parsed_pages"
  has_many :words

  field :source,          type: String
  field :title,           type: String
  field :original_time,   type: String
  field :datetime,        type: Time
  field :views,           type: Integer
  field :comments,        type: Integer
  field :content,         type: String
  field :article_id,      type: Integer
  field :url,             type: String
  field :mentions,        type: Hash
  field :total_mentions,  type: Integer
  field :has_words,       type: Boolean


  index({ datetime: 1 }, {name: "datetime_index"})

  scope :without_words, ->{ where(:has_words => nil) }

  def self.pick_without_words(count)
    without_words.desc(:datetime).limit(count).to_a
  end
end
