class CreatePoems < ActiveRecord::Migration
  def change
    create_table :poems do |t|
      t.string :title
      t.text :body
      t.references :user

      t.timestamps
    end
    add_index :poems, :user_id

    Reading.create(title:"beginning", content:"It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way \- in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.", author:"Charles Dickens", summary:"A very good beginning", sentencely:true, phrasely: true, paragraphly:true, source:"Tale of Two Cities", library_id:0)
  end
end
