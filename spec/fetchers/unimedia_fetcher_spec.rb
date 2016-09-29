require_relative '../../fetchers/unimedia'

describe UnimediaFetcher do
  it_behaves_like "a fetcher" do
    let(:fetcher) { subject }

    let(:valid_ids) do
      %w(94985 94998 94983)
    end

    let(:invalid_ids) do
      %w(857438)
    end
  end
end
