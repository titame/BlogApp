class RemoveTagsFromBlog < ActiveRecord::Migration
  def change
    remove_column :blogs, :tags, :text
  end
end
