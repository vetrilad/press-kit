require_relative '../../fetchers/publika'

describe PublikaFetcher do

  context "connect to the url", :vcr  do
    let(:publica_fetcher) { PublikaFetcher.new }

    before do
      allow_any_instance_of(described_class).to receive(:most_recent_id).and_return(100)
      allow_any_instance_of(described_class).to receive(:latest_stored_id).and_return(90)
    end

      it "#saves" do
        expect(publica_fetcher).to receive(:save).exactly(11).times
        publica_fetcher.run
      end

  end
end

