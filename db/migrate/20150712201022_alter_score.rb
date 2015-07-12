class AlterScore < ActiveRecord::Migration
  def change
    add_column :stories, :points_text, :text
  end
end
