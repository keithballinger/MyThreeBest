class AddFacebookIdToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :facebook_id, :string
    add_index :photos, :facebook_id
  end

  def self.down
    remove_column :photos, :facebook_id
  end
end
