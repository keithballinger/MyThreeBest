class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.integer :inviter_id
      t.integer :invited_id
      t.string :status

      t.timestamps
    end
    add_index :invites, :inviter_id
  end

  def self.down
    drop_table :invites
  end
end
