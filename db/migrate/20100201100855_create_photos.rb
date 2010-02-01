class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.belongs_to  :album, :null => false
      
      t.string      :title
      t.text        :desc
      
      t.string      :image_file_name
      t.string      :image_content_type
      t.integer     :image_file_size
      t.datetime    :image_updated_at

      t.timestamps
    end
    
    add_index :photos, :album_id
  end

  def self.down
    drop_table :photos
  end
end
