class AddTypeToStory < ActiveRecord::Migration
  def change
      add_column :stories, :type, :text
  end
end
