class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.integer 		:position
      t.references 	:paragraph, null: false

      t.timestamps
    end
    add_index :sentences, :paragraph_id
  end
end
