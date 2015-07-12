class AddColumnsToStory < ActiveRecord::Migration
  def change
    add_column :stories, :points, :integer
    add_column :stories, :source, :text
  end
end
