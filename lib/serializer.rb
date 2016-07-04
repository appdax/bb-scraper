require 'app_dax/serializer'
require 'feeds/volume_feed'
require 'feeds/macd_feed'
require 'feeds/roc_feed'
require 'feeds/rsi_feed'

# JSON serializer for stock class. The serializer goes through all feeds,
# generates their content and serializes them to one JSON encoded string.
# If a feed is empty because maybe the partial isn't available then it will
# not be included.
class Serializer < AppDax::Serializer
  source :bloomberg
  feeds VolumeFeed, MacdFeed, RocFeed, RsiFeed
end
