class AddCommentNameAndLink < ActiveRecord::Migration
  def change
    add_column :stories, :comment_name, :text
    add_column :stories, :comment_link, :text
  end
end
