class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :post
      t.references :user
      t.references :blog

      t.timestamps
    end
  end
end
