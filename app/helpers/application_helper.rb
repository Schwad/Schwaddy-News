require "#{Rails.root}/app/helpers/scrapers/collectedscrapers"
include CollectedScrapers

module ApplicationHelper

  def updates_page
    remove_all
    scrapes
  end

  def remove_all
    @old_stories = []
    @old_scores = []
    if Story.all.count > 0
      Story.all.each do |story|
        @old_stories << story.source
        if story.points_text != nil
          @old_scores << story.points_text.split(" ")[0].to_i
        else
          puts "problem with #{story.source}"
        end
      end
      Story.destroy_all
    end
  end
end
