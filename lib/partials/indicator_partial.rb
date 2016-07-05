require 'app_dax/partial'

# Represent the value for an indicator of a certain day.
class IndicatorPartial < AppDax::Partial
  # The value of the indicator.
  #
  # @return [ Float ] A 2-digit number.
  def value
    data[:value].round(2)
  rescue
    nil
  end

  # The MACD signal value. Only relevant for MACD!
  #
  # @return [ Float ] A 2-digit number.
  def signal
    data[:signal].round(2)
  rescue
    nil
  end

  # The diff between macd value and signal. Only relevant for MACD!
  #
  # @return [ Float ] A 2-digit number.
  def diff
    data[:diff].round(2)
  rescue
    nil
  end

  # The date of the indicator value.
  #
  # @return [ Int ] Relative number of days between today and the date.
  def age
    diff_in_days data[:date]
  rescue
    nil
  end
end
