require "#{Rails.root}/app/helpers/application_helper/scrapers/techmeme"
require "#{Rails.root}/app/helpers/application_helper/scrapers/reddit"
require "#{Rails.root}/app/helpers/application_helper/scrapers/ycombinator"

include RedditHelper
include YCombinatorHelper
include TechMemeHelper

module CollectedScrapers


end