require 'app_dax/multi_feed'

# Feed extract time-series informations about the RSI indicator.
class RsiFeed < AppDax::MultiFeed
  age_from :rsi

  kpis_from rsi: %i(value)
end
