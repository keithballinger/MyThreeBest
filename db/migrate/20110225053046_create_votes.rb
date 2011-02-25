class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :voter_id, :null => false
      t.integer :photo_id, :null => false

      t.timestamps
    end
    add_index :votes, :voter_id
    add_index :votes, :photo_id
    add_index :votes, [:voter_id, :photo_id]
  end

  def self.down
    drop_table :votes
  end
end
