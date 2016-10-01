require_relative '../../fetchers/publika'

describe PublikaFetcher do
  it_behaves_like "a fetcher" do
    let(:fetcher) { subject }

    let(:valid_ids) {%w(2699211 2700361 2755861)}

    let(:invalid_ids) { %w(90) }
  end
end
