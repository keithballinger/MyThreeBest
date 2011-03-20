class AddPublicPageUrlToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :public_page_url, :string
    add_index :users, :public_page_url
  end

  def self.down
    remove_column :users, :public_page_url
  end
end
