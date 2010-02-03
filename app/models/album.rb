class Album < ActiveRecord::Base

  belongs_to        :owner, :class_name => "User", :foreign_key => "user_id"
  has_many          :photos, :dependent => :delete_all
  belongs_to        :cover_photo, :class_name => "Photo"

  # We use this to access photo image, not saving our own images
  has_attached_file :image, Photo::IMAGE_OPTIONS.merge(:default_url => "/images/empty_album.png")
  
  validates_presence_of :name
  
  def image_file_name(*params)
    self.cover_photo_id ? "" : nil
  end
  
  def custom_param
    self.cover_photo_id
  end
  
  def thumbnail_url
    self.image && self.image.url(:thumb)
  end

end
