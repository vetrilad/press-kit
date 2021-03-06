require_relative '../../parsers/unimedia'

describe UnimediaParser do
  it_behaves_like "a parser" do
    let(:parser) { described_class.new }

    let(:valid_ids) { %w(73110) }
    let(:invalid_ids) { %w(10211) }

    before do
      parser.page_dir = 'spec/fixtures/unimedia/'
    end
  end
end
