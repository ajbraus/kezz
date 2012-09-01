class CreateSentances < ActiveRecord::Migration
  def change
    create_table :sentances do |t|
      t.integer 		:position
      t.references 	:paragraph, null: false

      t.timestamps
    end
    add_index :sentances, :paragraph_id
  end
end
