class AddNotifiedToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :notified, :boolean, :null => false, :default => false
    add_index :comments, :notified
    
    Comment.reset_column_information
    Comment.update_all :notified => true
  end

  def self.down
    remove_column :comments, :notified
  end
end
