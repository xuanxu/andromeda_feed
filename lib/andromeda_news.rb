require_relative 'util'
include Util

yesterday_papers = astroph_andromeda_daily_query

papers.each do |paper|
  title = paper.title
  url = paper.url
  # twitter_client send post "#{title}\n#{url}"
end
