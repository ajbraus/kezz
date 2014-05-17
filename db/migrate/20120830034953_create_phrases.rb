class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
    	t.string			:text, null: false
      t.integer 		:position
      t.references 	:sentence, null: false

      t.timestamps
    end
    add_index :phrases, :sentence_id

    execute("ALTER SEQUENCE phrases_id_seq START with 10000 RESTART;")
  end
end
