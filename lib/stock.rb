require 'app_dax/stock'
require 'partials/rsi_partial'
require 'partials/roc_partial'
require 'partials/volume_partial'
require 'partials/macd_partial'

# Each instance of class Stock indicates one finance security. The provided
# informations are either the MACD, RSI or ROC indicator.
#
# @example Initializing a stock.
#   stock = Stock.new(scraped-data)
#
# @example MACD series values
#   stock.macd.first.value
#   #=> 4.08
#   stock.macd.first.signal
#   #=> 5.31
#   stock.macd.first.diff
#   #=> -1.23
#
# @example RSI series values
#   stock.rsi.value
#   #=> 69.12
#   stock.rsi.age_in_days
#   #=> 0
#
# @example ROC series values
#   stock.roc.value
#   #=> 69.12
#   stock.roc.age_in_days
#   #=> 0
#
# @example Volume series values
#   stock.volume.value
#   #=> 6912
#   stock.volume.age_in_days
#   #=> 0
class Stock < AppDax::Stock
  # Use symbol instead of ISIN for identification
  id :symbol

  # Represents a series of daily RSI (Relative Strength Index) values.
  #
  # @return [ RsiPartial ] Enumerable values.
  def rsi
    @rsi ||= RsiPartial.new(data, url)
  end

  # Represents a series of daily ROC (Rate of Change) values.
  #
  # @return [ RocPartial ] Enumerable values.
  def roc
    @roc ||= RocPartial.new(data, url)
  end

  # Represents a series of daily volume values.
  #
  # @return [ VolumePartial ] Enumerable values.
  def volume
    @volume ||= VolumePartial.new(data, url)
  end

  # Represents a series of daily MACD values, signals
  # plus the difference between them.
  #
  # @return [ VolumePartial ] Enumerable values.
  def macd
    @macd ||= MacdPartial.new(data, url)
  end

  # Bloomberg's ticker symbol.
  #
  # @return [ String ] 3-character alpha-numerical code.
  def symbol
    data[:id].split(':').first
  rescue
    nil
  end
end
