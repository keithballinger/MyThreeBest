class AddPublicPageToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :public_page, :boolean, :default => :true
  end

  def self.down
    remove_column :users, :public_page
  end
end
