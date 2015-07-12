module ApplicationHelper

  def updates_page
    remove_all
    update_ycombinator
    # update_reddit
    # update_longform
    # update_thebrowser
    # update_slashdot
    # update_thefeature
    # update_techmeme
  end

  def remove_all
    if Story.all.count > 0
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

    while iterator < @scores.length
      Story.create(
          :source => @y_stories[0][iterator],
          :href => @y_stories[1][iterator],
          :points_text => @scores[iterator]
        )
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



end
