class AddTypeToVersion < ActiveRecord::Migration
  def change
  	add_column :versions , :typ , :integer
  end
end
