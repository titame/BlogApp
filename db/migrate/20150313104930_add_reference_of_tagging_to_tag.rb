class AddReferenceOfTaggingToTag < ActiveRecord::Migration
  def change
    add_reference :tags, :tagging
  end
end
