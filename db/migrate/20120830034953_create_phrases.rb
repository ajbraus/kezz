class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
    	t.string			:text, null: false
      t.integer 		:position
      t.references 	:sentence, null: false

      t.timestamps
    end
    add_index :phrases, :sentence_id
  end
end
