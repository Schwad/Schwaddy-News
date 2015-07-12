module ApplicationHelper

  def updates_page
    remove_all
    update_ycombinator
    update_reddit
    update_longform
    update_thebrowser
    update_slashdot
    update_thefeature
    update_techmeme
  end

  def remove_all
    Story.destroy_all
  end

  def update_ycombinator
    @a = Mechanize.new
    @a = @a.get('https://news.ycombinator.com/')
  end

  def get_y_stories
    @y_stories = []
    @a.links_with(:href => /http/).each do |link|

    end
  end

  def get_y_scores
    @a.search('span.score').each do |score|
    end
  end



end
