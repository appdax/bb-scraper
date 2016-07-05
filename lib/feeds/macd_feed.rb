require 'app_dax/multi_feed'

# Feed extract time-series informations about the MACD indicator.
class MacdFeed < AppDax::MultiFeed
  age_from :macd

  kpis_from macd: %i(value signal diff age)
end
