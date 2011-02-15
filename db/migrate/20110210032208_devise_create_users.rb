class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
      t.string :first_name
      t.string :last_name
      t.string :facebook_uid, :null => false
      t.string :facebook_token

      t.trackable
      t.timestamps
    end

    add_index :users, :facebook_uid, :unique => true
    #add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :users
  end
end
