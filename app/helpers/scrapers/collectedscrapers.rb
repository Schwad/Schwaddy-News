require "#{Rails.root}/app/helpers/scrapers/techmeme"
require "#{Rails.root}/app/helpers/scrapers/reddit"
require "#{Rails.root}/app/helpers/scrapers/ycombinator"

include RedditHelper
include YCombinatorHelper
include TechMemeHelper

module CollectedScrapers


end