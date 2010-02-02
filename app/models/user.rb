class User < ActiveRecord::Base

  acts_as_authentic

  has_many :albums, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_attached_file :avatar,  :styles => { :small => "48x48#", :normal => "64x64#" },
                              :url  => "/assets/avatars/:id/:style/:basename.:extension",
                              :path => ":rails_root/public/assets/avatars/:id/:style/:basename.:extension"

  validates_presence_of   :login
  validates_uniqueness_of :login
  
  validates_presence_of   :email
  validates_uniqueness_of :email

  validates_presence_of   :name
  
end
