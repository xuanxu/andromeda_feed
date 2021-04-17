require_relative 'util'

class AndromedaFeed
  include Util

  def update_papers
    yesterday_papers = astroph_andromeda_daily_query

    yesterday_papers.each do |paper|
      title = paper.title
      url = paper.url
      twitter_client.update("#{emojis.sample} #{title}\n#{url}")
    end

    yesterday_papers.size
  end

  def update_apod
    pic = apod_today
    m31_in_apod = pic.title.to_s.include? "Andromeda"

    if m31_in_apod
      image_file = File.open(URI.open(apod_image_url(pic)))
      twitter_client.update_with_media("#{pic.title} #{apod_url_today}", image_file)
    end

    m31_in_apod
  end

  def emojis
    %w(✨ 🛰 🌠 💫 🚀 🌌 💥 ⚡️ 📃 🔭 🌟)
  end
end
