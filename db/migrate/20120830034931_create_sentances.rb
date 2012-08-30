class CreateSentances < ActiveRecord::Migration
  def change
    create_table :sentances do |t|
      t.integer :position
      t.references :reading

      t.timestamps
    end
    add_index :sentances, :reading_id
  end
end
