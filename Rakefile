require_relative 'lib/andromeda_feed'

namespace :andromeda do
  desc "Tweet new papers in arXiv"
  task :update_papers do
    AndromedaFeed.new.update_papers
  end

  desc "Tweet APOD if Andromeda is in it"
  task :update_apod do
    AndromedaFeed.new.update_apod
  end
end
