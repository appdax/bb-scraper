require 'app_dax/multi_feed'

# Feed extract time-series informations about the traded volume.
class VolumeFeed < AppDax::MultiFeed
  age_from :volume

  kpis_from volume: %i(value)
end
