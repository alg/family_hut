class AddNotifiedToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :notified, :boolean, :null => false, :default => 0
    add_index :photos, :notified
    
    Photo.reset_column_information
    Photo.all.each(&:notified!)
  end

  def self.down
    remove_index :photos, :notified
    remove_column :photos, :notified
  end
end
