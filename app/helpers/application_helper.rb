require "#{Rails.root}/app/helpers/scrapers/collectedscrapers"
include CollectedScrapers

module ApplicationHelper

  def updates_page
    remove_all
    update_ycombinator
    update_reddit
    update_techmeme
    # update_longform
    # update_thebrowser
    # update_slashdot
    # update_thefeature

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

  #put everything you may need later down here
end
