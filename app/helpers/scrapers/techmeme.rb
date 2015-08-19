module TechMemeHelper

  def update_techmeme
    initialize_techmeme
    get_techmeme_stories_and_links
    get_techmeme_scores
    build_techmeme_stories
  end

  def initialize_techmeme
    puts "Updating techmeme...."
    @a = Mechanize.new
    @a = @a.get('http://www.techmeme.com/river')
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

  def build_techmeme_stories
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
end