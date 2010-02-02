class PhotosController < InheritedResources::Base

  before_filter :require_user
  belongs_to :album
  
  def create
    create! { parent_url }
  end
  
  def destroy
    destroy! { parent_url }
  end

end
