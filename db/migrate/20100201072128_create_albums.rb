class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string      :name, :null => false
      t.references  :user, :null => false

      t.timestamps
    end
    
    add_index :albums, :user_id
  end

  def self.down
    drop_table :albums
  end
end
