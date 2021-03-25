require 'twitter'
require 'arx'

module Util

  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV["TW_ANDROMEDAFEED_API_KEY"]
      config.consumer_secret = ENV["TW_ANDROMEDAFEED_SECRET_KEY"]
    end
  end

  def astroph_andromeda_daily_query(day=Date.today.prev_day)
    subcats = ['GA', 'CO', 'EP', 'HE', 'IM', 'SR']
    all_categories = subcats.map {|subcat| "astro-ph." + subcat}
    day = day.strftime("%Y%m%d")
    Arx(sort_by: :date_submitted, sort_order: :descending) do |query|
      query.category(all_categories, connective: :or)
      query.title('Andromeda Galaxy', 'M31', connective: :or)
      query.last_updated_date("[#{yesterday}0000 TO #{yesterday}2359]", exact: false)
    end
  end

end
