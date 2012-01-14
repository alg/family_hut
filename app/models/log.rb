class Log < ActiveRecord::Base

  belongs_to :user
  serialize :data

  attr_accessible :activity, :data, :user

end
