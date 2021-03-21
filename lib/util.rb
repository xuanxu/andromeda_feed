require 'twitter'
require 'arx'

module Util

  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV["TW_ANDROMEDAFEED_API_KEY"]
      config.consumer_secret = ENV["TW_ANDROMEDAFEED_SECRET_KEY"]
    end
  end

  def astroph_andromeda_query
    subcats = ['GA', 'CO', 'EP', 'HE', 'IM', 'SR']
    Arx(sort_by: :date_submitted, sort_order: :descending) do |query|
      query.category('astro-ph.*')
      query.title('Andromeda Galaxy', 'M31', connective: :or)
    end
  end

end
