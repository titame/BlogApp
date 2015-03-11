class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.text :tags
      t.string :status, null: false, default: "post-created"

      t.timestamps
    end
  end
end
