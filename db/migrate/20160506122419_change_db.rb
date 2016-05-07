class ChangeDb < ActiveRecord::Migration
  def change
  	remove_column :checkins , :version
  	remove_column :photos , :room_id
  	add_column :photos , :version_id , :integer
  	remove_column :reports , :version
  	remove_column :reports , :room_id
  	add_column :reports , :version_id , :integer
  	add_column :versions , :room_id , :integer
  	add_column :versions , :status , :integer , default: 0
  	remove_column :voteups , :version
  	remove_column :voteups , :room_id
  	add_column :voteups , :version_id , :integer
  end
end
