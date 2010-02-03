class AddImageFieldsToAlbums < ActiveRecord::Migration
  def self.up
    add_column :albums, :cover_photo_id,      :integer
  end

  def self.down
    remove_column :albums, :cover_photo_id
  end
end
