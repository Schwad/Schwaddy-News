class NameSpacePointsChange < ActiveRecord::Migration
  def change
    remove_column :stories, :points_change, :integer
    add_column :stories, :altering_of_the_points, :integer
  end
end
