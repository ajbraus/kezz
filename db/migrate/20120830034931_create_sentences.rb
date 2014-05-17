class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.integer 		:position
      t.references 	:paragraph, null: false

      t.timestamps
    end
    add_index :sentences, :paragraph_id

    execute("ALTER SEQUENCE sentences_id_seq START with 1000 RESTART;")
  end
end
