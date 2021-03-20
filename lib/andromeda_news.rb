require_relative 'util'

papers = astroph_andromeda_query

papers.each do |paper|
  title = paper.title
  url = paper.url
  puts "* #{title} (#{url})"
end
