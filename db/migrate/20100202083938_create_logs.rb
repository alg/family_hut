class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.references  :user,      :null => false
      t.string      :activity,  :null => false
      t.text        :message

      t.timestamps
    end
    
    add_index :logs, :created_at
  end

  def self.down
    drop_table :logs
  end
end
