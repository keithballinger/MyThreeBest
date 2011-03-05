class AddTopPhotosToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :top_photo_one_id, :integer
    add_column :users, :top_photo_two_id, :integer
    add_column :users, :top_photo_three_id, :integer
  end

  def self.down
    remove_column :users, :top_photo_three_id
    remove_column :users, :top_photo_two_id
    remove_column :users, :top_photo_one_id
  end
end
