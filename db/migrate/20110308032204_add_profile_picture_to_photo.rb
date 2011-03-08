class AddProfilePictureToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :profile_picture, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :photos, :profile_picture
  end
end
