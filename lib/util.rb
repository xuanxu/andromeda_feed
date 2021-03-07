module Util

  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TW_ANDROMEDAFEED_API_KEY"]
      config.consumer_secret     = ENV["TW_ANDROMEDAFEED_SECRET_KEY"]
    end
  end

end