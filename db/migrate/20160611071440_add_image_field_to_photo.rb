class AddImageFieldToPhoto < ActiveRecord::Migration
  def change
  	add_column :photos , :photo_url , :string
  	add_column :photos , :cloud , :boolean , default: true
  end
end
