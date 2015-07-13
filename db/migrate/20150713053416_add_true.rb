class AddTrue < ActiveRecord::Migration
  def change
    add_column :stories, :is_new, :boolean
  end
end
