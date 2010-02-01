class AddPhotosCountToAlbums < ActiveRecord::Migration
  def self.up
    add_column :albums, :photos_count, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :albums, :photos_count
  end
end
