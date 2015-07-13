class AddPointChanges < ActiveRecord::Migration
  def change
    add_column :stories, :points_change, :integer
  end
end
