class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
    	t.string			:text, null: false
      t.integer 		:position
      t.references 	:sentance, null: false

      t.timestamps
    end
    add_index :phrases, :sentance_id
  end
end
