class CreateUserJobs < ActiveRecord::Migration
  def self.up
    create_table :user_jobs do |t|
      t.string :job_id
      t.integer :user_id
      t.string :type

      t.timestamps
    end
    add_index :user_jobs, [:user_id, :type]
  end

  def self.down
    drop_table :user_jobs
  end
end
