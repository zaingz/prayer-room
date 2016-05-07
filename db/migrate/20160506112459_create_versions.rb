class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :name
      t.string :street
      t.string :floor
      t.string :city
      t.string :country
      t.text :description
      t.text :direction
      t.string :link

      t.timestamps null: false
    end
  end
end
