class AddUserToReports < ActiveRecord::Migration
  def change
  	add_column :reports , :reporter_id , :integer
  end
end
