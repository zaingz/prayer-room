class CreateVoteups < ActiveRecord::Migration
  def change
    create_table :voteups do |t|
      t.integer :votes
      t.integer :user_id
      t.integer :room_id
      t.timestamps null: false
    end
  end
end
