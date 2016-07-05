RSpec.describe MacdPartial do
  let(:raw) { IO.read('spec/fixtures/amzn.macd.json') }
  let(:json) { JSON.parse(raw, symbolize_names: true) }
  let(:partial) { described_class.new(json, url) }

  describe '#items' do
    subject { partial.items }

    context 'when response contains no values about the MACD' do
      let(:url) { 'time-series/study/rsi/AMZN:US' }
      it { is_expected.to be_empty }
    end

    context 'when response contains values about the MACD' do
      let(:url) { 'time-series/study/macd/AMZN:US' }
      it { is_expected.to_not be_empty }

      it('should be reverse ordered by age') do
        expect(subject.first.age).to be < subject.last.age
      end

      describe '#signal' do
        subject { partial.items.first.signal }
        it { is_expected.to eq(20.49) }
      end

      describe '#diff' do
        subject { partial.items.first.diff }
        it { is_expected.to eq(-1.5) }
      end
    end
  end
end
