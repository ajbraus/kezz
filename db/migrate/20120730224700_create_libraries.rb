class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :name, null: false
      t.string :description
      t.references :user, null: false

      t.timestamps
    end
    add_index :libraries, :user_id
  end
end
