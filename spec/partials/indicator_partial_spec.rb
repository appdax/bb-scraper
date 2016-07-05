RSpec.describe IndicatorPartial do
  let(:raw) { IO.read('spec/fixtures/amzn.rsi.json') }
  let(:json) { JSON.parse(raw, symbolize_names: true)[:price][0] }
  let(:indicator) { described_class.new(json) }

  before { Timecop.freeze(Time.utc(2016, 7, 5)) }

  describe '#value' do
    subject { indicator.value }

    context 'when data contains value for' do
      it { is_expected.to eq(68.2) }
    end

    context 'when data contains no value for' do
      let(:json) { nil }
      it { is_expected.to be_nil }
    end
  end

  describe '#age' do
    subject { indicator.age }

    context 'when data contains value for' do
      it { is_expected.to eq(29) }
    end

    context 'when data contains no value for' do
      let(:json) { nil }
      it { is_expected.to be_nil }
    end
  end

  describe '#signal' do
    context 'when data contains no value for' do
      subject { indicator.signal }
      let(:json) { nil }
      it { is_expected.to be_nil }
    end
  end

  describe '#diff' do
    context 'when data contains no value for' do
      subject { indicator.diff }
      let(:json) { nil }
      it { is_expected.to be_nil }
    end
  end
end
