class Post < ActiveRecord::Base

  MAX_DELETABLE_PERIOD = 60 # minutes
  
  belongs_to :user

  acts_as_textiled :body

  def removable_by?(user = nil)
    owned_by?(user) && created_not_too_long_ago?
  end

  private
  
  def owned_by?(user)
    self.user == user
  end
  
  def created_not_too_long_ago?
    (Time.now - self.created_at) < MAX_DELETABLE_PERIOD.minutes
  end
  
end
