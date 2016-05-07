class RemoveVersionId < ActiveRecord::Migration
  def change
  	remove_column :rooms , :version_id
  end
end
