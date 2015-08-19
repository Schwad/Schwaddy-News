module YCombinatorHelper
 def update_ycombinator
    puts "Updating ycombinator stories..."
    @a = Mechanize.new
    @a = @a.get('https://news.ycombinator.com/')
    get_y_stories_and_links
    get_y_scores
    get_y_comments
    iterator = 0
    @new_story = true

    while iterator < @scores.length
      change = 0
      if @old_stories.include?(@y_stories[0][iterator])
        change = @scores[iterator].split(" ")[0].to_i - @old_scores[@old_stories.index(@y_stories[0][iterator])]
        if change == nil
          change = 0
        end
        Story.create(
          :source => @y_stories[0][iterator],
          :href => @y_stories[1][iterator],
          :points_text => @scores[iterator],
          :originplace => 'Hacker News',
          :is_new => false,
          :altering_of_the_points => change,
          :comment_name => @y_comments[0][iterator],
          :comment_link => @y_comments[1][iterator]
        )
      else
        Story.create(
          :source => @y_stories[0][iterator],
          :href => @y_stories[1][iterator],
          :points_text => @scores[iterator],
          :originplace => 'Hacker News',
          :is_new => true,
          :altering_of_the_points => 0,
          :comment_name => @y_comments[0][iterator],
          :comment_link => @y_comments[1][iterator]
        )
      end

      iterator += 1
    end
    puts "Ycombinator stories updated!"
  end

  def get_y_stories_and_links
    @y_stories = [[],[]]
    @a.links_with(:href => /http/).each do |link|
      unless link.href.include?('ycombinator')
        @y_stories[0] << link.text
        @y_stories[1] << link.href
      end
    end
  end

  def get_y_scores
    @scores = []
    @a.search('span.score').each do |score|
      @scores << score.text
    end
  end

  def get_y_comments
    puts "pulling in ycombinator comments..."
    @y_comments = [[],[]]
    @comment_skip = true
    @a.links_with(:text => /comments/).each do |comment|
      if @comment_skip == true
        @comment_skip = false
      else
        @y_comments[0] << comment.text
        @y_comments[1] << "https://news.ycombinator.com/#{comment.href}"
      end
    end
  end
end