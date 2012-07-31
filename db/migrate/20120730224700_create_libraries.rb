class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :description
      t.references :user

      t.timestamps
    end
    add_index :libraries, :user_id
  end
end
