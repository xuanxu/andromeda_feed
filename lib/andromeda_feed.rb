# frozen_string_literal: true

require_relative 'util'

class AndromedaFeed
  include Util

  def update_papers
    yesterday_papers = astroph_andromeda_daily_query

    yesterday_papers.each do |paper|
      title = paper.title
      url = paper.url
      text = "#{emojis.sample} #{title}\n#{url}"

      begin
        tweet_body = { text: text }
        x_client.post("tweets", tweet_body.to_json)
        puts "  Paper twitted!"
      rescue Exception => e
        puts "  ‼️💥 ERROR posting paper to X: #{e.message}"
      end

      begin
        mastodon_post(text, nil)
        puts "  Paper posted to Mastodon!"
      rescue Exception => e
        puts "  ‼️💥 ERROR posting paper to Mastodon: #{e.message}"
      end

      begin
        text = "#{emojis.sample} #{title}"
        bluesky_post(text, url, nil)
        puts "  Paper posted to Bluesky!"
      rescue Exception => e
        puts "  ‼️💥 ERROR posting paper to Bluesky: #{e.message}"
      end
    end

    yesterday_papers.size
  end

  def update_apod
    pic = apod_today
    m31_in_apod = pic.title.to_s.include? "Andromeda"

    if m31_in_apod
      text = "#{pic.title} #{apod_url_today}"
      image_file_url = apod_image_url(pic)
      image_file = File.open(URI.open(image_file_url))

      begin
        mastodon_post(text, image_file)
        puts "  APOD posted to Mastodon!"
      rescue Exception => e
        puts "  ‼️💥 ERROR sending image to Mastodon: #{e.message}"
      end

      begin
        uploaded_media = x_media(image_file.path, image_file_url)
        tweet_body = {text: text, media: {media_ids: [uploaded_media["media_id_string"]]}}

        x_client.post("tweets", tweet_body.to_json)
        puts "  APOD twitted!"
      rescue Exception => e
        puts "  ‼️💥 ERROR sending image to X: #{e.message}"
      end
    end

    m31_in_apod
  end

  def emojis
    %w(✨ 🛰 🌠 💫 🚀 🌌 💥 ⚡️ 📃 🔭 🌟)
  end
end
