class AddRemoveColumns < ActiveRecord::Migration
  def change
  	remove_column :rooms , :voteup
  	add_column :photos , :version , :integer
  	add_column :reports , :version , :integer
  	add_column :checkins , :version , :integer
  	add_column :voteups , :version , :integer
  end
end
