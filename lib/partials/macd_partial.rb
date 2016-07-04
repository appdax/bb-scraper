require 'app_dax/multi_partial'
require 'partials/indicator_partial'

# Represents a series of daily MACD value, signal and the difference. See the
# IndicatorPartial class for more information about its content.
class MacdPartial < AppDax::MultiPartial
  # Represents a series of daily ROC values.
  #
  # @param [ Array<Hash> ] data The serialized raw data.
  # @param [ String ] url The URL from where the data comes from.
  #
  # @return [ RocPartial ] self
  def initialize(data, _)
    return super nil, IndicatorPartial unless data[:data]

    data = data[:data][:MACD].each.with_index do |item, index|
      item[:signal] = data[:data][:MACD_SIGNAL][index][:value]
      item[:diff]   = data[:data][:MACD_DIFF][index][:value]
    end

    super data.reverse!, IndicatorPartial
  end
end
