require 'fakefs/spec_helpers'
require 'hashdiff'

RSpec.describe Scraper do
  %w(stock_class serializer_class fields).each do |attr|
    describe "::#{attr}" do
      subject { described_class.send attr }
      it { is_expected.to_not be_nil }
    end
  end

  describe '::content_type' do
    subject { described_class.content_type }
    it { is_expected.to be(:json) }
  end

  describe '::stocks_per_request' do
    subject { described_class.stocks_per_request }
    it { is_expected.to eq(1) }
  end

  describe 'field URLs' do
    subject { described_class.new.send(:urls_for, [symbol], [field])[0] }

    context 'when asking for AMZN:US and MACD' do
      let(:symbol) { 'AMZN:US' }
      let(:field) { :macd }
      it { is_expected.to eq('http://www.bloomberg.com/markets/api/security/time-series/study/macd/AMZN:US?timeFrame=1_MONTH') }
    end

    context 'when asking for AMZN:US and volume' do
      let(:symbol) { 'AMZN:US' }
      let(:field) { :volume }
      it { is_expected.to eq('http://www.bloomberg.com/markets/api/security/time-series/volume/AMZN:US?timeFrame=1_MONTH') }
    end
  end

  describe '#run' do
    include FakeFS::SpecHelpers

    before do
      described_class.fields(:rsi, :roc, :macd, :volume)
      described_class.parallel_requests 1
    end

    context 'when scraping AMZN:US' do
      let(:content) { IO.read('spec/fixtures/amzn.rsi.json') }

      before do
        FileUtils.rm_rf described_class.drop_box

        stub_request(:get, %r{/AMZN:US?}).to_return body: '{}'
        stub_request(:get, %r{/rsi/AMZN:US?}).to_return body: content

        @count = described_class.new.run(['AMZN:US'])
      end

      it('should return 1') { expect(@count).to eq(1) }

      describe 'serialized files' do
        let(:entries) { Dir.glob "#{described_class.drop_box}/*.json" }
        let(:raw) { File.read(entries[0]) }

        it { expect(entries.count).to eq(1) }

        it('should be valid JSON files') do
          expect { JSON.parse(raw) }.to_not raise_error
        end

        it('should look like expected') do
          unified  = JSON.parse(raw)
          expected = JSON.parse(IO.read('spec/fixtures/serialized.rsi.json'))

          expect(HashDiff.diff(unified, expected)).to be_empty
        end
      end
    end
  end
end
