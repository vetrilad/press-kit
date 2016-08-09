require_relative '../../parsers/publika'

describe "PubliKaParser" do

  it "detects if the document has data to parse" do
    publika_parser = PublikaParser.new
    publika_parser.page_dir = 'spec/fixtures/publika/'
    doc = publika_parser.load_doc(54)
    expect(publika_parser.parse(doc, 54)).to_not be nil
  end

  it "Finds the text within a document" do

  end
end