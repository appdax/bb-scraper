require 'app_dax/scraper'
require 'serializer'
require 'stock'

# To scrape all data about a stock from consorsbank.de the Scraper class takes
# a list of of ISIN numbers and a set of fields to scrape for. Once a stock been
# scraped the date gets serialed to JSON string and written down into a file.
#
# @example Scrape intraday data for facebook stock.
#   Scraper.new.run ['US30303M1027'], fields: :PriceV1
#
# @example Scrape all data for amazon stock.
#   Scraper.new.run ['AMZ:US']
class Scraper < AppDax::Scraper
  stock_class Stock
  serializer_class Serializer

  load_config(role: 'bb-scraper')

  base_url 'http://www.bloomberg.com/markets/api/security/time-series'
  content_type :json

  url_for_field do |kpi, sym|
    "#{base_url}/study/#{kpi}/#{sym}?timeFrame=1_MONTH"
  end

  url_for_field(:volume) do |_, sym|
    "#{base_url}/volume/#{sym}?timeFrame=1_MONTH"
  end
end
