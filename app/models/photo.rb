class Photo < ActiveRecord::Base

  IMAGE_OPTIONS = {
    :styles => { :tiny => "48x48#", :thumb => "128x128#", :brief => "256x256#", :full => "900x600" },
    :url    => "/assets/photos/:photo_id/:style.jpg",
    :path   => ":rails_root/public/assets/photos/:photo_id/:style.jpg" }

  belongs_to :album, :counter_cache => true
  has_attached_file :image, IMAGE_OPTIONS

  acts_as_commentable

  scope :with_image, where("image_file_name IS NOT NULL")
  scope :unnotified, where(:notified => false)

  before_save :normalize_title
  after_save :destroy_original

  private

  def notified!
    self.notified = true
    save!
  end
  
  def normalize_title
    self.title = "Untitled" if self.title.blank?
  end

  def destroy_original
    File.unlink(self.image.path)
  end
  
end
