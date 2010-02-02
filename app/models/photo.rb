class Photo < ActiveRecord::Base

  belongs_to :album, :counter_cache => true
  has_attached_file :image, :styles => { :thumb => "128x128#", :brief => "256x256#", :full => "900x600" },
                            :url  => "/assets/photos/:id/:style/:basename.:extension",
                            :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"

  acts_as_commentable

  before_save :normalize_title
  
  private
  
  def normalize_title
    self.title = nil if self.title.blank?
  end
end
