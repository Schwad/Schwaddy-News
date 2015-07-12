class CorrectType < ActiveRecord::Migration
  def change
    add_column :stories, :originplace, :text
  end
end
