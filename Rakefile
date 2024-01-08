require_relative 'lib/andromeda_feed'

namespace :andromeda do
  desc "Post new papers in arXiv"
  task :update_papers do
    papers_found = AndromedaFeed.new.update_papers
    case papers_found
    when 0
      puts "💔 No papers about Andromeda today"
    when 1
      puts "✨ A new paper about Andromeda!"
    else
      puts "✨ Yay! #{papers_found} new papers found and posted!"
    end
  end

  desc "Post APOD if Andromeda is in it"
  task :update_apod do
    apod_found = AndromedaFeed.new.update_apod
    if apod_found
      puts "✨ Andromeda is in today's APOD!"
    else
      puts "💔 Today's APOD does not include Andromeda"
    end
  end
end
