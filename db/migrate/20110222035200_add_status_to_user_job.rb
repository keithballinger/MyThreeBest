class AddStatusToUserJob < ActiveRecord::Migration
  def self.up
    add_column :user_jobs, :status, :string
  end

  def self.down
    remove_column :user_jobs, :status
  end
end
