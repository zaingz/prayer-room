class AddUsernameToUsers < ActiveRecord::Migration
  def change
  	add_column :users , :status , :integer , default: 0
  	add_column :users , :username , :string
  end
end
