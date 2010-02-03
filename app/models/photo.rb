class Photo < ActiveRecord::Base

  IMAGE_OPTIONS = {
    :styles => { :thumb => "128x128#", :brief => "256x256#", :full => "900x600" },
    :url  => "/assets/photos/:custom_param/:style.jpg",
    :path => ":rails_root/public/assets/photos/:custom_param/:style.jpg" }

  belongs_to :album, :counter_cache => true
  has_attached_file :image, IMAGE_OPTIONS

  acts_as_commentable

  named_scope :with_image, { :conditions => "image_file_name IS NOT NULL" }

  before_save :normalize_title
  
  def custom_param
    self.id
  end
  
  private
    
  def normalize_title
    self.title = "Untitled" if self.title.blank?
  end
end
