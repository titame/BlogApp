class RemoveValuesFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :values, :text
  end
end
