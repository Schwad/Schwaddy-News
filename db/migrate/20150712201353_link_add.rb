class LinkAdd < ActiveRecord::Migration
  def change
      add_column :stories, :href, :text
  end
end
