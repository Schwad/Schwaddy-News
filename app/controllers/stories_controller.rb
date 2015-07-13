class StoriesController < ApplicationController
  def index

    @y_stories = Story.where("originplace = 'Hacker News'")
    @r_stories = Story.where("originplace = 'Reddit Webdev'")
    @t_stories = Story.where("originplace = 'Techmeme'")
    iterator_one = 0
    iterator_two = 0
    @stories = []
    while @y_stories.length > iterator_two && @r_stories.length > iterator_two && @t_stories.length > iterator_two
      @stories[iterator_one] = @y_stories[iterator_two] if @y_stories.length > iterator_two
      iterator_one += 1
      @stories[iterator_one] = @r_stories[iterator_two] if @r_stories.length > iterator_two
      iterator_one += 1
      @stories[iterator_one] = @t_stories[iterator_two] if @t_stories.length > iterator_two
      iterator_one += 1
      iterator_two += 1
    end
  end
end
