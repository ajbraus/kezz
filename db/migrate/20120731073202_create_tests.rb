class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.buttfucker :string

      t.timestamps
    end
  end
end
