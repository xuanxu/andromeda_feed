require_relative 'lib/andromeda_feed'

namespace :andromeda do
  desc "Tweet new papers in arXiv"
  task :update_papers do
    AndromedaFeed.new.update_papers
  end
end
