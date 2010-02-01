class PhotosController < InheritedResources::Base

  before_filter :require_user
  belongs_to :album
  
  def destroy
    destroy!{ parent_url }
  end

end
