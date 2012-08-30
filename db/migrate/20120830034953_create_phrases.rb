class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.integer :position
      t.references :reading

      t.timestamps
    end
    add_index :phrases, :reading_id
  end
end
