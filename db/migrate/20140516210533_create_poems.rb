class CreatePoems < ActiveRecord::Migration
  def change
    create_table :poems do |t|
      t.string :title
      t.text :body
      t.references :user

      t.timestamps
    end
    add_index :poems, :user_id
  end
end
