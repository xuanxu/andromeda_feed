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
    if pic.title.to_s.include? "Andromeda"
      twitter_client.update("#{pic.title} #{apod_url_today}")
    end
  end

  def emojis
    %w(✨ 🛰 🌠 💫 🚀 🌌 💥 ⚡️ 📃 🔭 🌟)
  end
end
