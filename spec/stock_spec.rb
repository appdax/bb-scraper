RSpec.describe Stock do
  let(:raw) { IO.read('spec/fixtures/amzn.macd.json') }
  let(:json) { JSON.parse(raw, symbolize_names: true) }
  let(:stock) { described_class.new(json, 'time-series/study/macd/') }

  describe '::id' do
    subject { described_class.id }
    it { is_expected.to eq(:symbol) }
  end

  describe '#symbol' do
    subject { stock.symbol }

    context 'when its available' do
      it { is_expected.to eq('AMZN') }
    end

    context 'when its not available' do
      let(:json) { {} }
      it { is_expected.to be_nil }
    end
  end

  describe '#id' do
    subject { stock.id }
    it { is_expected.to eq(stock.symbol) }
  end

  describe '#rsi' do
    context 'when received data for the MACD indicator' do
      subject { stock.rsi.items }
      it { is_expected.to be_empty }
    end
  end

  describe '#roc' do
    context 'when received data for the MACD indicator' do
      subject { stock.roc.items }
      it { is_expected.to be_empty }
    end
  end

  describe '#volume' do
    context 'when received data for the MACD indicator' do
      subject { stock.volume.items }
      it { is_expected.to be_empty }
    end
  end

  describe '#macd' do
    context 'when received data for the MACD indicator' do
      subject { stock.macd.items }
      it { is_expected.to_not be_empty }
    end
  end
end
