require 'app_dax/multi_partial'
require 'partials/indicator_partial'

# Represents a series of daily ROC (Rate of Change) values. See the
# IndicatorPartial class for more information about its content.
class RocPartial < AppDax::MultiPartial
  # Represents a series of daily ROC values.
  #
  # @param [ Array<Hash> ] data The serialized raw data.
  # @param [ String ] url The URL from where the data comes from.
  #
  # @return [ RocPartial ] self
  def initialize(data, url)
    super url.include?('/roc') ? data[:price].reverse! : nil, IndicatorPartial
  end
end
