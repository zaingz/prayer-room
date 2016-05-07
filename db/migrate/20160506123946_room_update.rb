class RoomUpdate < ActiveRecord::Migration
  def change
  	remove_column :rooms , :name
  	remove_column :rooms , :street
  	remove_column :rooms , :floor
  	remove_column :rooms , :city
  	remove_column :rooms , :country
  	remove_column :rooms , :description
  	remove_column :rooms , :direction
  	remove_column :rooms , :link
  	remove_column :rooms , :status
  	remove_column :rooms , :version
  	add_column :rooms , :version_id , :integer
  end
end
