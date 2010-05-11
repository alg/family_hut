class Photo < ActiveRecord::Base

  IMAGE_OPTIONS = {
    :styles => { :tiny => "48x48#", :thumb => "128x128#", :brief => "256x256#", :full => "900x600" },
    :url    => "/assets/photos/:photo_id/:style.jpg",
    :path   => ":rails_root/public/assets/photos/:photo_id/:style.jpg",
    :tags   => { :photo_id => lambda { |attachment, style| attachment.instance.id } } }

  belongs_to :album, :counter_cache => true
  has_attached_file :image, IMAGE_OPTIONS

  acts_as_commentable

  named_scope :with_image, { :conditions => "image_file_name IS NOT NULL" }

  before_save :normalize_title
  
  private
    
  def normalize_title
    self.title = "Untitled" if self.title.blank?
  end
  
end
