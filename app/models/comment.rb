class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates_presence_of :comment

  scope :unnotified, where(:notified => false)

  attr_accessible :comment

end
