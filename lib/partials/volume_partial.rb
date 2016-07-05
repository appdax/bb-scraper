require 'app_dax/multi_partial'
require 'partials/indicator_partial'

# Represents a series of daily traded volume values. See the
# IndicatorPartial class for more information about its content.
class VolumePartial < AppDax::MultiPartial
  # Represents a series of daily volume values.
  #
  # @param [ Array<Hash> ] data The serialized raw data.
  # @param [ String ] url The URL from where the data comes from.
  #
  # @return [ VolumePartial ] self
  def initialize(data, url)
    data = data && url.include?('/volume') ? (data[:price] || []).reverse! : nil

    super data, IndicatorPartial
  end
end
