require 'app_dax/multi_partial'
require 'partials/indicator_partial'

# Represents a series of daily RSI (Relative Strength Index) values. See the
# IndicatorPartial class for more information about its content.
class RsiPartial < AppDax::MultiPartial
  # Represents a series of daily RSI values.
  #
  # @param [ Array<Hash> ] data The serialized raw data.
  # @param [ String ] url The URL from where the data comes from.
  #
  # @return [ RsiPartial ] self
  def initialize(data, url)
    data = data && url.include?('/rsi') ? data.fetch(:price, []).reverse! : nil

    super data, IndicatorPartial
  end
end
