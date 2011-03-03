class CreatePhotoPermissions < ActiveRecord::Migration
  def self.up
    create_table :photo_permissions do |t|
      t.integer :photo_id, :null => false
      t.integer :owner_id, :null => false
      t.integer :friend_id, :null => false

      t.timestamps
    end
    add_index :photo_permissions, :friend_id
  end

  def self.down
    drop_table :photo_permissions
  end
end
