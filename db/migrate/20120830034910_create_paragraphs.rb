class CreateParagraphs < ActiveRecord::Migration
  def change
    create_table :paragraphs do |t|
      t.integer :position
      t.references :reading

      t.timestamps
    end
    add_index :paragraphs, :reading_id
  end
end
