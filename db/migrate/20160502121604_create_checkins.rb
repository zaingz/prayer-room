class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :rating
      t.integer :user_id
      t.integer :room_id
      t.timestamps null: false
    end
  end
end
