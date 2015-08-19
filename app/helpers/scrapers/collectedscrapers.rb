require "#{Rails.root}/app/helpers/scrapers/techmeme"
require "#{Rails.root}/app/helpers/scrapers/reddit"
require "#{Rails.root}/app/helpers/scrapers/ycombinator"

include RedditHelper
include YCombinatorHelper
include TechMemeHelper

module CollectedScrapers
  #this is a touch refactored, can be DRY'd up but do not want to overdo it because of how tenuous scraping can be.
  def scrapes
    update_ycombinator
    update_reddit
    update_techmeme
    # update_longform
    # update_thebrowser
    # update_slashdot
    # update_thefeature
  end

end