class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :author
      t.string :summary
      t.integer :rating
      t.boolean :sentancely
      t.boolean :phrasely
      t.boolean :paragraphly
      t.references :library, null: false

      t.timestamps
    end
    add_index :readings, :library_id
  end
end
