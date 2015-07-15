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

  def update_ycombinator
    puts "Updating ycombinator stories..."
    @a = Mechanize.new
    @a = @a.get('https://news.ycombinator.com/')
    get_y_stories_and_links
    get_y_scores
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
          :altering_of_the_points => change
        )
      else
        Story.create(
          :source => @y_stories[0][iterator],
          :href => @y_stories[1][iterator],
          :points_text => @scores[iterator],
          :originplace => 'Hacker News',
          :is_new => true,
          :altering_of_the_points => 0
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
        @reddit_stories[0] << article.text
        @reddit_stories[1] << article.to_s.scan(/href="(.*)." /)[0][0]
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

  def update_techmeme
    puts "Updating techmeme...."
    @a = Mechanize.new
    @a = @a.get('http://www.techmeme.com/river')
    get_techmeme_stories_and_links
    get_techmeme_scores
    iterator = 0
    @new_story = true
    puts "Creating stories..."
    while iterator < @techmeme_scores.length
      change = 0
      if @old_stories.include?(@techmeme_stories[0][iterator])
        change = @techmeme_scores[iterator].split(" ")[0].to_i - @old_scores[@old_stories.index(@techmeme_stories[0][iterator])]
        if change == nil
          change = 0
        end
        Story.create(
          :source => @techmeme_stories[0][iterator],
          :href => @techmeme_stories[1][iterator],
          :points_text => @techmeme_scores[iterator],
          :originplace => 'Techmeme',
          :is_new => false,
          :altering_of_the_points => change
        )
      else
        Story.create(
          :source => @techmeme_stories[0][iterator],
          :href => @techmeme_stories[1][iterator],
          :points_text => @techmeme_scores[iterator],
          :originplace => 'Techmeme',
          :is_new => true,
          :altering_of_the_points => 0
        )
      end
      iterator += 1
    end
    puts "techmeme updated!"

  end

  def get_techmeme_stories_and_links
    @techmeme_stories = [[],[]]
    @iterator = 3
    @a.links[17..47].each do |article|
      if @iterator % 2 == 1
        @techmeme_stories[0] << article.text
        @techmeme_stories[1] << article.href
      end
      @iterator += 1
    end
  end

  def get_techmeme_scores
    @techmeme_scores = []
    @iterator = @techmeme_stories[0].length
    while @iterator >= 0
      @techmeme_scores << "#{@iterator} points"
      @iterator -= 1
    end
  end
end
