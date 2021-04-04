require_relative 'util'

class AndromedaFeed
  include Util

  def update
    yesterday_papers = astroph_andromeda_daily_query

    papers.each do |paper|
      title = paper.title
      url = paper.url
      twitter_client.update("#{emojis.sample} #{title}\n#{url}")
    end
  end

  def emojis
    %w(✨ 🛰 🌠 💫 🚀 🌌 💥 ⚡️ 📃 🔭 🌟)
  end
end