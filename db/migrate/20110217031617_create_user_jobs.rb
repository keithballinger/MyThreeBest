class CreateUserJobs < ActiveRecord::Migration
  def self.up
    create_table :user_jobs do |t|
      t.string :job_id, :null => false
      t.integer :user_id, :null => false
      t.string :job_type, :null => false

      t.timestamps
    end
    add_index :user_jobs, [:user_id, :job_type]
  end

  def self.down
    drop_table :user_jobs
  end
end
