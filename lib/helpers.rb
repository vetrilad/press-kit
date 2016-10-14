module Helpers
  def doc
    Nokogiri::HTML(page, nil, 'UTF-8')
  end
end