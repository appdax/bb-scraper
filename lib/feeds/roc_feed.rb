require 'app_dax/multi_feed'

# Feed extract time-series informations about the ROC indicator.
class RocFeed < AppDax::MultiFeed
  age_from :roc

  kpis_from roc: %i(value age)
end
