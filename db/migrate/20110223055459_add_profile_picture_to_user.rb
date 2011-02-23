class AddProfilePictureToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :profile_picture, :string
  end

  def self.down
    remove_column :users, :profile_picture
  end
end
