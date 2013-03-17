class AddImgUrlToLibrary < ActiveRecord::Migration
  def change
  	add_column :libraries, :img_url, :string
  end
end
