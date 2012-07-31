class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.string :title
      t.string :content
      t.string :author
      t.string :summary
      t.integer :rating
      t.references :library

      t.timestamps
    end
    add_index :readings, :library_id
  end
end
