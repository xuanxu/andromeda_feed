require_relative 'lib/andromeda_feed'

namespace :andromeda do
  desc "Tweet new papers in arXiv"
  task :update_papers do
    papers_found = AndromedaFeed.new.update_papers
    case papers_found
    when 0
      puts "No papers about Andromeda today"
    when 1
      puts "A new paper about Andromeda!"
    else
      puts "Yay! #{papers_found} new papers found and tweeted!"
    end
  end

  desc "Tweet APOD if Andromeda is in it"
  task :update_apod do
    AndromedaFeed.new.update_apod
  end
end
