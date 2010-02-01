class Album < ActiveRecord::Base

  belongs_to  :owner, :class_name => "User", :foreign_key => "user_id"
  has_many    :photos, :dependent => :delete_all
  
  validates_presence_of :name
  
  def thumbnail_url
    photos.count == 0 ? nil : photos.first.image.url(:thumb)
  end

end
