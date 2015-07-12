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




end
