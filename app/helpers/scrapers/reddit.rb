module RedditHelper

  def update_reddit
    puts "Updating reddit...."
    @a = Mechanize.new
    @a = @a.get('https://www.reddit.com/r/webdev')
    get_reddit_stories_and_links
    get_reddit_scores
    iterator = 0
    @new_story = true
    puts "Creating stories..."
    while iterator < @reddit_scores.length
      change = 0
      if @old_stories.include?(@reddit_stories[0][iterator])
        change = @reddit_scores[iterator].split(" ")[0].to_i - @old_scores[@old_stories.index(@reddit_stories[0][iterator])]
        if change == nil
          change = 0
        end
        Story.create(
          :source => @reddit_stories[0][iterator],
          :href => @reddit_stories[1][iterator],
          :points_text => @reddit_scores[iterator],
          :originplace => 'Reddit Webdev',
          :is_new => false,
          :altering_of_the_points => change
        )
      else
        Story.create(
          :source => @reddit_stories[0][iterator],
          :href => @reddit_stories[1][iterator],
          :points_text => @reddit_scores[iterator],
          :originplace => 'Reddit Webdev',
          :is_new => true,
          :altering_of_the_points => 0
        )
      end

      iterator += 1
    end
    puts "Reddit updated!"
  end

  def get_reddit_stories_and_links
    @reddit_stories = [[],[]]
    @a.search('a.title.may-blank').each do |article|
      begin
        story_link = article.to_s.scan(/href="(.*)" /)[0][0]
        if story_link[0..2] == "/r/"
          story_link = "http://www.reddit.com" + story_link
        end
        @reddit_stories[0] << article.text
        @reddit_stories[1] << story_link
      rescue
        binding.pry
      end
    end
  end

  def get_reddit_scores
    @reddit_scores = []
    @a.search('div.score.unvoted').each do |score|
      @reddit_scores << "#{score.text} points"
    end
  end
end