class Album < ActiveRecord::Base

  DEFAULT_IMAGE_URL = "/images/empty_album.gif"
  
  include AlbumNavigation

  belongs_to  :owner, :class_name => "User", :foreign_key => "user_id"
  belongs_to  :cover_photo, :class_name => "Photo"
  has_many    :photos, :dependent => :delete_all, :order => "id desc",
                :after_add    => :invalidate_photo_ids_cache,
                :after_remove => :invalidate_photo_ids_cache

  # We use this to access photo image, not saving our own images
  has_attached_file :image, Photo::IMAGE_OPTIONS.merge(:default_url => DEFAULT_IMAGE_URL)
  
  validates_presence_of :name
    
  def image_file_name(*params)
    self.cover_photo_id ? "" : nil
  end
  
  def thumbnail_url(style = :thumb)
    self.image.url(style)
  end

end
