class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.text :title
      t.string :url, :null => false
      t.string :preview_url
      t.integer :user_id, :null => false
      t.integer :total_votes, :default => 0

      t.timestamps
    end

    add_index :photos, :user_id
  end

  def self.down
    drop_table :photos
  end
end
