class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.string :value

      t.timestamps
    end
  end
end
