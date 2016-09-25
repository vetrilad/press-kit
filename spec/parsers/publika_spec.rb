require_relative '../../parsers/publika'

describe PublikaParser do
  let(:publika_parser) { described_class.new }

  let(:valid_ids) { %w(10211) }
  let(:invalid_ids) { %w(15) }

  before do
    publika_parser.page_dir = 'spec/fixtures/publika/'
  end

  context "detects if the document has data to parse" do

    it "has data" do
      valid_ids.each do |id|
        doc = publika_parser.load_doc(id)
        expect(publika_parser.parse(doc, id)).to_not be nil
      end
    end

    it "does not have data" do
      invalid_ids.each do |id|
        doc = publika_parser.load_doc(id)
        expect(publika_parser.parse(doc, id)).to be nil
      end
    end
  end

  it "Finds the text within a document" do
    valid_ids.each do |id|
      doc = publika_parser.load_doc(id)
      expect(publika_parser.parse(doc, id)).to be_kind_of Hash
    end
  end
end
