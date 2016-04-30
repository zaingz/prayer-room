class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :status
      t.integer :room_id

      t.timestamps null: false
    end
  end
end
