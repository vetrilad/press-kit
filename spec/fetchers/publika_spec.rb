require_relative '../../fetchers/publika'

describe PublikaFetcher do
  it_behaves_like "a fetcher" do
    let(:fetcher) { subject }

    let(:valid_ids) do
      %w(2699211 2700361 2755861)
    end

    let(:invalid_ids) do
      %w(90)
    end
  end
end
