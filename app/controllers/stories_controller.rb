class StoriesController < ApplicationController
  def index
    @stories = Story.cycle_for_mobile
  end
end
