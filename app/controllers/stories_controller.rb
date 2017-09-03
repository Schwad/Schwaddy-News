class StoriesController < ApplicationController
  def index
    Story.cycle_for_mobile
  end
end
