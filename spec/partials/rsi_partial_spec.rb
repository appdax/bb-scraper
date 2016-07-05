RSpec.describe RsiPartial do
  let(:raw) { IO.read('spec/fixtures/amzn.rsi.json') }
  let(:json) { JSON.parse(raw, symbolize_names: true) }
  let(:partial) { described_class.new(json, url) }

  describe '#items' do
    subject { partial.items }

    context 'when response contains RSI values' do
      let(:url) { 'time-series/study/rsi/AMZN:US' }

      it { is_expected.to_not be_empty }

      it('should be reverse ordered by age') do
        expect(subject.first.age).to be < subject.last.age
      end
    end

    context 'when response contains no RSI values' do
      let(:url) { 'time-series/study/roc/AMZN:US' }
      it { is_expected.to be_empty }
    end
  end
end
