class Post < ActiveRecord::Base

  MAX_DELETABLE_PERIOD = 60 # minutes
  
  belongs_to :user

  acts_as_textiled :body

  def can_be_deleted?(user = nil)
    self.user == user && (Time.now - self.created_at) < MAX_DELETABLE_PERIOD.minutes
  end
  
end
