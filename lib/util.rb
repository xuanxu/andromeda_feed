require 'twitter'
require 'arx'
require 'nasa_apod'
require 'date'
require "faraday"
require "faraday/multipart"
require "json"
require "digest"

module Util

  def apod_client
    @apod_client ||= NasaApod::Client.new(api_key: ENV["NASA_APOD_API_KEY"])
  end

  def apod_today
    apod_client.search(date: Date.today)
  end

  def apod_url_today
    "https://apod.nasa.gov/apod/ap#{Date.today.strftime("%y%m%d")}.html"
  end

  def apod_image_url(pic)
    case pic.media_type
    when "image"
      pic.url
    when "video"
      pic.thumbnail_url
    else
      pic.url
    end
  end

  def twitter_client
    @tw_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TW_ANDROMEDAFEED_API_KEY"]
      config.consumer_secret     = ENV["TW_ANDROMEDAFEED_API_SECRET_KEY"]
      config.access_token        = ENV["TW_ANDROMEDAFEED_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TW_ANDROMEDAFEED_ACCESS_TOKEN_SECRET"]
    end
  end

  def mastodon_post(text, media_file)
    headers = { "Authorization" => "Bearer #{ENV["MASTODON_ANDROMEDAFEED_TOKEN"]}" }

    mastodon_url = "https://astrodon.social"
    media_path = "/api/v2/media"
    status_url = "https://astrodon.social/api/v1/statuses"

    parameters = { status: text }

    unless media_file.nil?
      conn = Faraday.new(mastodon_url) do |f|
        f.request :multipart
      end

      payload = {}
      payload[:file] = Faraday::FilePart.new(media_file, "image")

      attachment = conn.post(media_path, payload, headers)
      if attachment.status.between?(200, 299)
        parameters[:media_ids] = [JSON.parse(attachment.body)["id"]].compact
      end
    end

    headers["Idempotency-Key"] = Digest::SHA1.hexdigest(text)
    Faraday.post(status_url, parameters, headers)
  end

  def astroph_andromeda_daily_query(day=Date.today.prev_day)
    subcats = ['GA', 'CO', 'EP', 'HE', 'IM', 'SR']
    all_categories = subcats.map {|subcat| "astro-ph." + subcat}
    day = day.strftime("%Y%m%d")
    Arx(sort_by: :submitted_at, sort_order: :descending) do |query|
      query.category(all_categories, connective: :or)
      query.title('Andromeda Galaxy', 'M31', connective: :or)
      query.updated_at("[#{day}0000 TO #{day}2359]", exact: false)
    end
  end
end
