require_relative '../../parsers/publika'

describe "PubliKaParser" do

  context "detects if the document has data to parse" do

    it "has data" do
      publika_parser = PublikaParser.new
      publika_parser.page_dir = 'spec/fixtures/publika/'
      doc = publika_parser.load_doc(2699211)
      expect(publika_parser.parse(doc, 2699211)).to_not be nil
    end

    it "does not have data" do
      publika_parser = PublikaParser.new
      publika_parser.page_dir = 'spec/fixtures/publika/'
      doc = publika_parser.load_doc(15)
      expect(publika_parser.parse(doc, 15)).to be nil
    end
  end


  # it "Finds the text within a document" do
  #   publika_parser = PublikaParser.new
  #   publika_parser.page_dir = 'spec/fixtures/publika/'
  #
  # end
end