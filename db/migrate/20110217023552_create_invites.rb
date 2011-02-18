class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.integer :inviter_id, :null => false
      t.integer :invited_id, :null => false
      t.string :status, :null => false

      t.timestamps
    end
    add_index :invites, :inviter_id
  end

  def self.down
    drop_table :invites
  end
end
