class AddPhotosPostsTable < ActiveRecord::Migration
  def self.up
    create_table :photos_posts, :force => false do |t|
      t.integer :photo_id, :null => false
      t.integer :post_id,  :null => false
    end
    
    add_index :photos_posts, :photo_id
    add_index :photos_posts, :post_id
  end

  def self.down
    drop_table :photos_posts
  end
end
