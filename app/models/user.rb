class User < ActiveRecord::Base

  acts_as_authentic

  has_many :albums
  
  validates_presence_of   :login
  validates_uniqueness_of :login
  
  validates_presence_of   :email
  validates_uniqueness_of :email

  validates_presence_of   :name
  
end
