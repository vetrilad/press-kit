require_relative '../../parsers/publika'

describe PublikaParser do
  it_behaves_like "a parser" do
    let(:parser) { described_class.new }

    let(:valid_ids) { %w(10211) }
    let(:invalid_ids) { %w(15) }

    before do
      parser.page_dir = 'spec/fixtures/publika/'
    end
  end
end
