require_relative '../../fetchers/publika'

describe PublikaFetcher do

  context "connect to the url", :vcr do
    let(:publica_fetcher) { PublikaFetcher.new }

    describe "outgoing requests" do
      before do
        allow_any_instance_of(described_class).to receive(:most_recent_id).and_return(100)
        allow_any_instance_of(described_class).to receive(:latest_stored_id).and_return(90)
        allow_any_instance_of(described_class).to receive(:valid?).and_return(true)
      end

      it "#saves" do
        expect(publica_fetcher).to receive(:save).exactly(11).times
        publica_fetcher.run
      end
    end

    describe "reading the page content", :vcr do
      let(:valid_ids) do
        %w(2699211 2700361 2755861)
      end

      let(:invalid_ids) do
        %w(90)
      end

      it "#valid page is checked" do
        expect(publica_fetcher).to receive(:save).exactly(3).times

        valid_ids.each do |id|
          publica_fetcher.fetch_single(id)
        end
      end

      it "#invalid page is not saved" do
        expect(publica_fetcher).to receive(:save).exactly(0).times

        invalid_ids.each do |id|
          publica_fetcher.fetch_single(id)
        end
      end
    end
  end
end


