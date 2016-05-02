class UpdateRoom < ActiveRecord::Migration
  def change
  	remove_column :rooms , :checkin
  	add_column :rooms , :version , :integer , default: 0
  	add_column :rooms , :voteup , :integer , default: 0
  end
end
