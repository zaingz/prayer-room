class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :street
      t.string :floor
      t.string :city
      t.string :country
      t.text :description
      t.text :direction
      t.string :link
      t.integer :checkin ,default: 0
      t.integer :status , default: 0

      t.timestamps null: false
    end
  end
end
