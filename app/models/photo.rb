class Photo < ActiveRecord::Base

  IMAGE_OPTIONS = {
    :styles => { :thumb => "128x128#", :brief => "256x256#", :full => "900x600" },
    :url    => "/assets/photos/:photo_id/:style.jpg",
    :path   => ":rails_root/public/assets/photos/:photo_id/:style.jpg",
    :tags   => { :photo_id => lambda { |attachment, style| attachment.instance.id } } }

  belongs_to :album, :counter_cache => true
  has_attached_file :image, IMAGE_OPTIONS

  acts_as_commentable

  named_scope :with_image, { :conditions => "image_file_name IS NOT NULL" }

  before_save :normalize_title
  
  # def image_width(style_name)
  #   image_geometry(style_name).try(:width).try(:to_i)
  # end
  # 
  # def image_height(style_name)
  #   image_geometry(style_name).try(:height).try(:to_i)
  # end
  # 
  private
    
  def normalize_title
    self.title = "Untitled" if self.title.blank?
  end
  # 
  # def image_geometry(style_name)
  #   self.image && Paperclip::Geometry.from_file(self.image.path(style_name))
  # end
  
end
